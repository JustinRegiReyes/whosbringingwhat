class AddAttendingEventIdToNotification < ActiveRecord::Migration
  def change
  	add_column :notifications, :attending_event_id, :integer
  end
end
