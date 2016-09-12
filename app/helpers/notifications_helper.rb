module NotificationsHelper
	def the_update(notification)
		if notification.what_kind == "guest"
			status = attending_events.where(event_id: notification.event_id).as_json.key(true)
			if status == 'going'
				notification.guest.username + " is attending " + notification.event.title
			elsif status == 'maybe'
				notification.guest.username + " is a maybe for " + notification.event.title
			elsif status == 'declined'
				notification.guest.username + " has declined to attend " + notification.event.title
			end
		elsif notification.what_kind == "friend_accepted"
			notification.friendship.friend.username + " has accepted your friend request!"
		elsif notification.what_kind == "friend_request"
			notification.friendship.user.username + " wants to be your friend."
		elsif notification.what_kind == "comment"
			notification.comment.user.username + " has commented in " + notification.comment.event.title
		elsif notification.what_kind == "invitation"
			notification.invited_by.username + " has invited you to " + notification.event.title
		end
	end

	def friend_request_notification(friendship)
		Notification.create({user_id: friendship.friend_id, friendship_id: friendship.id, what_kind: "friend_request"})
	end
end
