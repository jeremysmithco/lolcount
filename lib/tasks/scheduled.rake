namespace :scheduled do
  desc "Get LOLs"
  task :get_lols => :environment do

    puts "Get LOLs: #{Time.now}"
    
    tweet_attributes = Tweet.new.attributes().keys.push('id')
    latest_tweet = Tweet.find(:first, :select => :id, :order => 'id desc')
    
    begin
      
      break_next_time = false
      (1..3).each do |i|
        
        if i == 1
          search = Twitter::Search.new('#lol').per_page(100).since_id(latest_tweet.id)
        else
          search = Twitter::Search.new('#lol').per_page(100).max_id(latest_tweet.id).page(i)
        end
        search.each do |tweet|
          # get rid of attr in hash not being stored
          tweet.delete_if {|key,value| !tweet_attributes.include?(key) }
          tweet_exists = Tweet.exists?(tweet.id)
          puts "#{tweet.id}: #{tweet_exists}"
          if !tweet_exists
            Tweet.create(tweet) do |t|
              # force id, instead of autoincrementing
              t.id = tweet.id
            end
            #loler = User.find_by_screen_name(tweet.from_user) || User.create_from_screen_name(tweet.from_user)
          end
        end
        
        break if break_next_time

        if !search.next_page?
          puts "no next page after: #{i}"
          # go an extra page, to pick up any that could have been missed
          break_next_time = true
        end
        
      end
      
      
#      oauth = Twitter::OAuth.new(ConsumerToken, ConsumerSecret)
#      oauth.authorize_from_access(AccessToken, AccessSecret)
      
    rescue => e
      puts "Error: #{e}"
      #rake_logger.info "Error: #{e}"
      #system "echo \"Subject: Get LOLs\n\nError: #{e}\n\" | sendmail jeremy@bentoncreation.com"
    end
  
  end

end

def rake_logger
  @@rake_logger ||= Logger.new("#{RAILS_ROOT}/log/rake.log")
end