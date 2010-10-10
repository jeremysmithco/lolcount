namespace :scheduled do
  desc "Get LOLs"
  task :get_lols => :environment do

    puts "Get LOLs: #{Time.now}"
    
    tweet_attributes = Tweet.new.attributes().keys.push('id')
    latest_tweet = Tweet.find(:first, :select => :id, :order => 'id desc')
    
    begin
      
      Twitter::Search.new('#lol').per_page(100).since_id(latest_tweet.id).each do |tweet|
        # get rid of attr in hash not being stored
        tweet.delete_if {|key,value| !tweet_attributes.include?(key) }
        Tweet.create(tweet) do |t|
          # force id, instead of autoincremeting
          t.id = tweet.id
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