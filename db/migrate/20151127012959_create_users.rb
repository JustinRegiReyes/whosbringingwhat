class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :username
      t.integer :category_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
