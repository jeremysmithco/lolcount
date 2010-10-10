class ChangeTweetIdsToBigint < ActiveRecord::Migration
  def self.up
    change_column :tweets, :id, :bigint
    change_column :lols, :tweet_id, :bigint
  end

  def self.down
    change_column :tweets, :id, :integer
    change_column :lols, :tweet_id, :integer
  end
end
