module NotificationsHelper
	def the_update(notification)
		if notification.what_kind == "invitation_update"
			status = notification.attending_event.as_json.key(true)
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
		elsif notification.what_kind == "invitation_request"
			notification.invited_by.username + " has invited you to " + notification.event.title
		end
	end

	def friend_request_notification(friendship)
		Notification.create({user_id: friendship.friend_id, friendship_id: friendship.id, what_kind: "friend_request"})
	end

	def invitation_notifications(attending_events)
		attending_events.each do |attending_event|
			Notification.create({user_id: attending_event.user.id, invited_by_id: current_user.id, attending_event_id: attending_event.id, event_id: attending_event.event.id, what_kind: "invitation_request"})
		end
	end

	def notification_count
		current_user.notifications.where({read: false}).count
	end

	def notification_icon(notification)
		if notification.what_kind == "friend_request"
			"<i class='fa fa-user-plus' aria-hidden='true'></i>".html_safe
		elsif notification.what_kind == "friend_accepted"
			"<i class='fa fa-user-plus accepted' aria-hidden='true'></i>".html_safe
		elsif notification.what_kind == "invitation_request"
			"<i class='fa fa-list-alt' aria-hidden='true'></i>".html_safe
		end
	end

	def notification_action(notification)
		if notification.what_kind == "friend_request"
			''.html_safe
		end
	end

	def notification_image(notification)
		if notification.what_kind == "friend_request"
			notification.friendship.user.avi
		elsif notification.what_kind == "friend_accepted"
			notification.friendship.friend.avi(:thumb)
		elsif notification.what_kind == "invitation_request"
			notification.event.photo(:thumb)
		end
	end

	def notification_default_action(notification)
		if notification.what_kind == "friend_request"
			"<button data-notification-id='#{notification.id}' data-friendship-id='#{notification.friendship_id}' data-notification-action='Accept' data-notification-kind='#{notification.what_kind}' class='notification-action'>Accept</button>".html_safe
		elsif notification.what_kind == "friend_accepted"
			
		elsif notification.what_kind == "invitation_request"
			"<button data-notification-id='#{notification.id}' data-attending-event-id='#{notification.attending_event_id}' data-notification-action='Accept' data-notification-kind='#{notification.what_kind}' class='notification-action'>Accept</button>".html_safe
		end
	end

	def notification_options(notification)
		if notification.what_kind == "friend_request"
			["<a class='dropdown-item' href='' data-notification-id='#{notification.id}' data-friendship-id='#{notification.friendship_id}' data-notification-action='Decline' data-notification-kind='#{notification.what_kind}'>Decline</a>"]
		elsif notification.what_kind == "friend_accepted"
			[""]
		elsif notification.what_kind == "friend_declined"
			[""]
		elsif notification.what_kind == "invitation_request"
			[
				"<a class='dropdown-item' href='' data-notification-id='#{notification.id}' data-attending-event-id='#{notification.event_id}' data-notification-action='Maybe' data-notification-kind='#{notification.what_kind}'>Maybe</a>",
				"<a class='dropdown-item' href='' data-notification-id='#{notification.id}' data-attending-event-id='#{notification.attending_event_id}' data-notification-action='Decline' data-notification-kind='#{notification.what_kind}'>Decline</a>"
			]
		end
	end

	def mark_notification_read(id)
		notification = Notification.find_by_id(id)
		notification.update({read: true})
	end

	def notification_friend_status(friendship_id, what_kind)
		friendship = Friendship.find_by_id(friendship_id)
		if what_kind == "friend_accepted"
			Notification.create({what_kind: "friend_accepted", user_id: friendship.user_id, friendship_id: friendship.id})
		elsif "friend_declined"
			Notification.create({what_kind: "friend_declined", user_id: friendship.user_id, friendship_id: friendship.id})
		end		
	end

	# supposed to update owner of event on the status of the current_users answer to the invitation
	def notification_update_invitation_status(attending_event_id, what_kind)
		# Notification.create({attending_event_id: attending_event_id, what_kind: what_kind})
	end
end
