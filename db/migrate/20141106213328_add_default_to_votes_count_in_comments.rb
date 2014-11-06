class AddDefaultToVotesCountInComments < ActiveRecord::Migration
  def change
    change_column :comments, :votes_count, :integer, :default => 0
  end
end
