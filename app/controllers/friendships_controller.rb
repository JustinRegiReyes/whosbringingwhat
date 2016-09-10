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

	end

	def friend_accept
		
	end

	private

	def friend_params
		params.require(:test)
	end
end
