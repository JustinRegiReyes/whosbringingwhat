class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :event_id
      t.integer :comment_id
      t.integer :friendship_id

      t.timestamps null: false
    end
  end
end
