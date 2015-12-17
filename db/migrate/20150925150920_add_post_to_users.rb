class AddPostToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post, :string
  end
end
