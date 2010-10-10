namespace :maintenance do
  desc "Create Users"
  task :create_users_and_lols => :environment do

    puts "Create Users: #{Time.now}"
        
    begin
      
        tweets = Tweet.find(:all)
        
        tweets.each do |tweet|
          tweet.create_users_and_lols_from_tweet
        end
      
    rescue => e
      puts "Error: #{e}"
      #rake_logger.info "Error: #{e}"
      #system "echo \"Subject: Create Users\n\nError: #{e}\n\" | sendmail jeremy@bentoncreation.com"
    end
  
  end

end

def rake_logger
  @@rake_logger ||= Logger.new("#{RAILS_ROOT}/log/rake.log")
end