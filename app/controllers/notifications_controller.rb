class NotificationsController < ApplicationController
	def my_notifications
		@notifications = current_user.notifications
	end
end