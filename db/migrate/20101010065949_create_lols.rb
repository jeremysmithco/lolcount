class CreateLols < ActiveRecord::Migration
  def self.up
    create_table :lols do |t|
      t.integer :loler_id
      t.integer :lolee_id
      t.integer :tweet_id

      t.timestamps
    end
  end

  def self.down
    drop_table :lols
  end
end
