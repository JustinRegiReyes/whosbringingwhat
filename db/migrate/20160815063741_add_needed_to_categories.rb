class AddNeededToCategories < ActiveRecord::Migration
  def change
  	add_column :categories, :needed, :integer, default: 0
  end
end
