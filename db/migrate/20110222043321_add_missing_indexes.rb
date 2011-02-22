class AddMissingIndexes < ActiveRecord::Migration
  def self.up
    add_index :lols, :loler_id
    add_index :lols, :lolee_id
    add_index :lols, :tweet_id
  end
  
  def self.down
    remove_index :lols, :loler_id
    remove_index :lols, :lolee_id
    remove_index :lols, :tweet_id
  end
end
