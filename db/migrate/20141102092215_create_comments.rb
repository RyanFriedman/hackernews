class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.text :text
      t.integer :votes_count, :default => 0

      t.timestamps
    end
  end
end
