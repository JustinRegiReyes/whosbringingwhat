class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :event_id
      t.text :post

      t.timestamps null: false
    end
  end
end
