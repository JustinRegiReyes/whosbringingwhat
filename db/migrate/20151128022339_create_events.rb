class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :photo
      t.string :banner
      t.integer :user_id
      t.text :description
      t.date :date_start
      t.date :date_end
      t.time :time_start
      t.time :time_end
      t.string :address
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :country
      t.string :where

      t.timestamps null: false
    end
  end
end
