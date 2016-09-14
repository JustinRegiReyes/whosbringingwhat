class Notification < ActiveRecord::Base
	belongs_to :user

	has_many :created_events, foreign_key: "user_id", class_name: "Event"

	def guest
		User.find_by_id(self.guest_id)
	end

	def friendship
		Friendship.find_by_id(self.friendship_id)
	end

	def comment
		Comment.find_by_id(self.comment_id)
	end

	def event
		Event.find_by_id(self.event_id)
	end

	def invited_by
		User.find_by_id(self.invited_by_id)
	end

	# def reference
	# 	if self.type == "guest"
	# 		self.guest
	# 	elsif self.type == "friend"
	# 		self.friend
	# 	elsif self.type == "comment"
	# 		self.comment
	# 	elsif self.type == "event"
	# 		self.event
	# 	end
	# end
end
