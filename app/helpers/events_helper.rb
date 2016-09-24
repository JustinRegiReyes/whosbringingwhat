module EventsHelper
	def send_invites_to_users(users, eventId)
		attendingEvents = []
		users.each do |user|
			ae = {event_id: eventId, user_id: user['friendId']}
			attendingEvents.push(ae)
		end
		created = AttendingEvent.create(attendingEvents) rescue nil
		if ( created != nil)
			return created
		else
			return false
		end
	end
end
