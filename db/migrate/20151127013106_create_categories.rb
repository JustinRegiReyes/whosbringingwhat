class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :user_id
      t.integer :event_id
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
