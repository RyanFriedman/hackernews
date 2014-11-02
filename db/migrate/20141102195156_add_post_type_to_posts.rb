class AddPostTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :post_type, :string, :default => "default"
  end
end
