class Friendship < ActiveRecord::Base
	belongs_to :user
	belongs_to :friend, :class_name => "User"

	before_destroy :destroy_notification

	def destroy_notification
		notification = Notification.where(friendship_id: self.id)
		if notification.count > 0
			notification.destroy_all
		end
	end
end
