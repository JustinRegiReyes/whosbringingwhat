class AddEventIdToAttendingEvent < ActiveRecord::Migration
  def change
    add_column :attending_events, :event_id, :integer
  end
end
