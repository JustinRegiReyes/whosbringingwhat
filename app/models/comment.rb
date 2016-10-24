class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :event

	after_create :notify_event_goers

	def notify_event_goers
		eventId = self.event_id
		attendingUsers = User.joins(:attending_events).where({attending_events: {event_id: eventId, going: true}}).where.not({users: {id: self.user_id}})
		event = self.event
		creator = event.user
		attendingUsers.push(creator)
		attendingUsers.each do |user|
			if self.user_id != user.id
				Notification.create({what_kind: "comment", comment_id: self.id, user_id: user.id, event_id: eventId})
			end
		end
	end

	def owner?(user)
		self.user_id == user.id
	end
end
