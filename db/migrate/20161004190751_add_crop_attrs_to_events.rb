class AddCropAttrsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :photo_crop_x, :string
    add_column :events, :photo_crop_y, :string
    add_column :events, :photo_crop_w, :string
    add_column :events, :photo_crop_h, :string
    add_column :events, :banner_crop_x, :string
    add_column :events, :banner_crop_y, :string
    add_column :events, :banner_crop_w, :string
    add_column :events, :banner_crop_h, :string
  end
end
