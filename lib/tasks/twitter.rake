namespace :twitter do
  desc "Get Tweets"
  task :get_tweets => :environment do

    rake_logger.info "Get Tweets: #{Time.now}"
    
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
          rake_logger.info "#{tweet.id}: #{tweet_exists}"
          if !tweet_exists
            Tweet.create(tweet) do |t|
              # force id, instead of autoincrementing
              t.id = tweet.id
            end
          end
        end
        
        break if break_next_time

        if !search.next_page?
          rake_logger.info "no next page after: #{i}"
          # go an extra page, to pick up any that could have been missed
          break_next_time = true
        end
        
      end
      
    rescue => e
      rake_logger.info "Error: #{e}"
      system "echo \"Subject: Get Tweets\n\nError: #{e}\n\" | sendmail jeremy@bentoncreation.com"
    end
  
  end

end

def rake_logger
  @@rake_logger ||= Logger.new("#{RAILS_ROOT}/log/rake.log")
end