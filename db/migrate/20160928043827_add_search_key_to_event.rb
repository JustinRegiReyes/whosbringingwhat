class AddSearchKeyToEvent < ActiveRecord::Migration
  def change
  	add_column :events, :search_key, :string
  end
end
