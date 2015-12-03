class AddUserIdToAttendingEvent < ActiveRecord::Migration
  def change
    add_column :attending_events, :user_id, :integer
  end
end
