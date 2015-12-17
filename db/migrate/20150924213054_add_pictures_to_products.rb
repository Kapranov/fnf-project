class AddPicturesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :pictures, :json
  end
end
