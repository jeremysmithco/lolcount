class User < ActiveRecord::Base
  validates_uniqueness_of :screen_name

end
