class NotificationsController < ApplicationController
	def my_notifications
		@notifications = current_user.notifications.where({read: false})
	end
end