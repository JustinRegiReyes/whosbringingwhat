module FriendshipsHelper
	def sort_invitable_friends(friends, eventId)
		invitableFriends = []
		friends.each do |f|
			invited_already = f.attending_events.pluck(:event_id).include?(eventId.to_i)
			if invited_already == false
				invitableFriends.push(f.as_json(:only => [:id,:username, :from], methods: [:avi_url]))
			end
		end
		return invitableFriends
	end
end
