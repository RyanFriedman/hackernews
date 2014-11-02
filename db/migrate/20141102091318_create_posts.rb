class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :user, index: true
      t.string :title
      t.string :url
      t.text :text
      t.integer :votes_count, :default => 0

      t.timestamps
    end
  end
end
