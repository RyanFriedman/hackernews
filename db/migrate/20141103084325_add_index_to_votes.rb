class AddIndexToVotes < ActiveRecord::Migration
  def change
     add_index :votes, [:voteable_id, :voteable_type, :user_id], :unique => true
  end
end
