class CreateAttendingEvents < ActiveRecord::Migration
  def change
    create_table :attending_events do |t|
      t.integer :user_id
      t.integer :event_id
      t.boolean :going
      t.boolean :maybe
      t.boolean :declined
      t.boolean :undecided, default: true

      t.timestamps null: false
    end
  end
end
