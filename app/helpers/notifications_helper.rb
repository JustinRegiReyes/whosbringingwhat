module NotificationsHelper
	def the_update(notification)
		if notification.type == "guest"
			status = attending_events.where(event_id: notification.event_id).as_json.key(true)
			if status == 'going'
				notification.guest.username + "is attending " + notification.event.title
			elsif status == 'maybe'
				notification.guest.username + "is a maybe for " + notification.event.title
			elsif status == 'declined'
				notification.guest.username + "has declined to attend " + notification.event.title
			end
		elsif notification.type == "friend"
			notification.friend.username + "has accepted your friend request!"
		elsif notification.type == "comment"
			notification.comment.user.username + "has commented in " + notification.comment.event.title
		elsif notification.type == "invitation"
			notification.invited_by.username + "has invited you to " + notification.event.title
		end
	end
end
