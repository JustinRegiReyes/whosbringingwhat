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
			friend_request_notification(friendship)
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
			notification_update(notification_id, "friend_accepted")
			respond_to do |format|
				flash[:success] = "Friend Accepted"
				format.html { render layout: false }
				format.json { render :json => {data: {friendshipId: friendship_id} }, status: 200 }
			end
			notification_friend_accepted(friendship_id)
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
			notification_update(notification_id, "friend_declined")
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
end
