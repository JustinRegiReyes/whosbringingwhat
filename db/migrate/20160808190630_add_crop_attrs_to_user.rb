class AddCropAttrsToUser < ActiveRecord::Migration
  def change
  	add_column :users, :crop_x, :string
  	add_column :users, :crop_y, :string
  	add_column :users, :crop_w, :string
  	add_column :users, :crop_h, :string
  end
end
