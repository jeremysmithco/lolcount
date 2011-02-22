class AddCounterCache < ActiveRecord::Migration
  def self.up
    add_column :users, :received_lol_count, :integer, :default => 0

    User.reset_column_information
    User.find(:all).each do |u|
      User.update_counters u.id, :received_lol_count => u.received_lols.length
    end
  end

  def self.down
    remove_column :users, :received_lol_count
  end

end
