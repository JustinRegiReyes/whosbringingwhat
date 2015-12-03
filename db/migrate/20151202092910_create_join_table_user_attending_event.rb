class CreateJoinTableUserAttendingEvent < ActiveRecord::Migration
  def change
    create_join_table :users, :attending_events do |t|
      t.index [:user_id, :attending_event_id]
      t.index [:attending_event_id, :user_id]
    end
  end
end
