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

	def event_banner(event)
		if event.default_banner? == true
			default_url = image_path(event.banner.url)
			"background-image: linear-gradient(to top right, rgba(0, 0, 0, .2), rgba(0, 0, 0, 0), rgba(0, 0, 0, 0)), url('" + default_url + "');".html_safe
		else
			event_banner = @event.banner(:large)
			return "background-image: linear-gradient(to top right, rgba(0, 0, 0, .2), rgba(0, 0, 0, 0), rgba(0, 0, 0, 0)), url( " + event_banner + ");".html_safe
		end
	end

	def own_event?(event)
		current_user.created_events.where({id: event.id}).length > 0
	end

end
