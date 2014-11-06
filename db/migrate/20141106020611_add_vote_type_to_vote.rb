class AddVoteTypeToVote < ActiveRecord::Migration
  def change
    add_column :votes, :vote_type, :string
  end
end
