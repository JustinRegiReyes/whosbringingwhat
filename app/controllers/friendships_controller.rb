class FriendshipsController < ApplicationController
  	def create
		@friendship = Friendship.new({friend_id: params[:friend_id]})
		if @friendship.save
			flash[:notice] = "Added friend."
			redirect_to root_url
		else
			flash[:error] = "Unable to add friend."
			redirect_to root_url
		end
	end

	def destroy
		@friendship = current_user.friendships.find_by(friend_id: params[:friend_id])
		@friendship.destroy
		flash[:notice] = "Removed friendship."
		redirect_to "/home"
	end

	def friend_request
		friendship = Friendship.where({user_id: current_user.id, friend_id: params[:friend_id]}).first
		if friendship != nil
			if friendship.update_attributes({pending: true})
				friend_request_notification(friendship)
				flash[:success] = "Friend request sent"
				redirect_to :back
			else 
				flash[:error] = "Error with last request"
			end
		elsif friendship == nil
			friendship = Friendship.new({user_id: current_user.id, friend_id: params[:friend_id]})
			if friendship.save
				flash[:success] = "Friend request sent"
				friend_request_notification(friendship)
				redirect_to :back
			else
				flash[:error] = "Friend request error"
				redirect_to :back
			end
		end
	end

	def friend_accept
		if targetFriendship.update_attributes(accepted: true, pending: false)
			if params_notification?
				mark_notification_read(notification_id)
			elsif params_notification? == false
				mark_notification_read(current_user.notifications.where({friendship_id: targetFriendship.id, read: false}).first.id)
			end
			respond_to do |format|
				flash[:success] = "Friend Accepted"
				format.html { render layout: false }
				format.json { render :json => {data: {friendshipId: friendship_id} }, status: 200 }
			end
			notification_friend_status(friendship_id, "friend_accepted")
	    else
	      	respond_to do |format|
				flash[:error] = "Error"
				format.html { render layout: false }
				format.json { render :json => {data: {friendshipId: friendship_id} }, status: 200 }
			end
	    end
	end

	def friend_decline
		if targetFriendship.update_attributes(pending: false)
			if params_notification?
				mark_notification_read(notification_id)
			elsif params_notification? == false
				mark_notification_read(current_user.notifications.where({friendship_id: targetFriendship.id, read: false}).first.id)
			end
			respond_to do |format|
				flash[:success] = "Friend Declined"
				format.html { render layout: false }
				format.json { render :json => {data: {friendshipId: friendship_id} }, status: 200 }
			end
	    else
	      	respond_to do |format|
				flash[:error] = "Error"
				format.html { render layout: false }
				format.json { render :json => {data: {friendshipId: friendship_id} }, status: 200 }
			end
	    end
	end

	def invite_friends
		# queries users that is not have been invited at all to the event and has an accepted friendship with the current_user
		friends = User.includes(:friendships).where(friendships: {friend_id: current_user.id, accepted: true} ).uniq
		invitableFriends = sort_invitable_friends(friends, event_id)
		respond_to do |format|
			format.html { render layout: false }
			format.json { render :json => {data: {friends: invitableFriends} }, status: 200 }
		end
	end

	def my_friend_requests
		@friend_requests = Friendship.where({pending: true, friend_id: current_user.id})
	end

	private

	def friend_params
		params.require(:test)
	end

	def friendship_id
		params[:friendship_id]
	end

	def notification_id
		params[:notification_id]
	end

	def targetFriendship
		Friendship.find_by_id(friendship_id)
	end

	def event_id
		params[:event_id]
	end

	def params_notification?
		params.has_key?(:notification)
	end
end
