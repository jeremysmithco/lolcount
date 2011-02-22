class Lol < ActiveRecord::Base
  belongs_to :tweet
  
  belongs_to :lolee, :class_name => "User", :counter_cache => :received_lol_count
end
