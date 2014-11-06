class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user, index: true
      t.text :text
      t.integer :votes_count

      t.timestamps
    end
  end
end
