class AddInvitedByToNotifications < ActiveRecord::Migration
  def change
  	add_column :notifications, :invited_by_id, :integer
  end
end
