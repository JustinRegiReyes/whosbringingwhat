class CreateAttendingEvents < ActiveRecord::Migration
  def change
    create_table :attending_events do |t|

      t.timestamps null: false
    end
  end
end
