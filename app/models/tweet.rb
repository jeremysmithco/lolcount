class Tweet < ActiveRecord::Base
  include Twitter::Extractor
  
  has_one :lol
  
  after_create :create_users_and_lols_from_tweet
  
  def create_users_and_lols_from_tweet
    mentioned_screen_names = extract_mentioned_screen_names(self.text)
    if !mentioned_screen_names.empty?
      
      #puts self.text; puts self.from_user; puts mentioned_screen_names.join(','); puts "-"*10
      
      from_user = User.find_by_screen_name(self.from_user) || User.create(:screen_name => self.from_user)
      
      mentioned_screen_names.each do |screen_name|
        to_user = User.find_by_screen_name(screen_name) || User.create(:screen_name => screen_name)
        
        Lol.create(:loler_id => from_user.id, :lolee_id => to_user.id, :tweet_id => self.id) unless from_user == to_user
      end
      
    end
  end

  
end
