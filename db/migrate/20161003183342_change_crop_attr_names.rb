class ChangeCropAttrNames < ActiveRecord::Migration
  def change
  	rename_column :users, :crop_x, :avi_crop_x
  	rename_column :users, :crop_y, :avi_crop_y
  	rename_column :users, :crop_w, :avi_crop_w
  	rename_column :users, :crop_h, :avi_crop_h
  end
end
