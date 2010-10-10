class User < ActiveRecord::Base
  validates_uniqueness_of :screen_name
  
  has_many :given_lols, :class_name => "Lol", :foreign_key => :loler_id
  has_many :received_lols, :class_name => "Lol", :foreign_key => :lolee_id
#  has_many :lolees, :through => :lols, :foreign_key => :lolee_id
#  has_many :lolers, :through => :lols, :foreign_key => :loler_id

end
