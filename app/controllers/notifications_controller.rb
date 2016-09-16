class NotificationsController < ApplicationController
	def my_notifications
		@notifications = current_user_notifications
	end

	def dismiss
		Notification.where(id: checkedNotifications).update_all(read: true)
		respond_to do |format|
			flash[:success] = "Notifications dismissed"
			format.json { render :json => {data: {success: "success"} }, status: 200 }
		end
	end

	def dismiss_all
		current_user_notifications.update_all(read: true)
	end

	private

	def checkedNotifications
		params[:checkedNotifications]
	end

	def current_user_notifications
		current_user.notifications.where({read: false})
	end
end