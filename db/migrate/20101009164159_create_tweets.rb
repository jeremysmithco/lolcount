class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :profile_image_url
      t.datetime :created_at
      t.string :from_user
      t.integer :to_user_id
      t.string :text
      t.integer :from_user_id
      t.integer :geo
      t.string :iso_language_code
      t.string :source

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
