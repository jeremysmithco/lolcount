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
          # force id, instead of autoincrementing
          t.id = tweet.id
        end
        
#        loler = User.find_by_screen_name(tweet.from_user) || User.create_from_screen_name(tweet.from_user)
        
        
        
      end

      #      mentions.each do |m|
      #        listener = user.listeners.find_by_screen_name(m['user']['screen_name']) || Listener.create_from_mention(self, m)      
      #        listener.increment!(:count)
      #      end
      #      update_attributes(:last_processed_at => Time.now, :last_processed_id => mentions.first['id'])

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