class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.integer :user_id
      t.text :description
      t.date :date
      t.time :time
      t.string :address
      t.string :city
      t.string :zipcode
      t.string :state
      t.string :country

      t.timestamps null: false
    end
  end
end
