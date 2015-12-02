class SessionsController < ApplicationController
  def new #login page
  	@user = User.new
  end

  def create #login
  	userParams = params.require(:user).permit(:username, :password)
  	@user = User.confirm(userParams)
  	if @user
  		login(@user)
  		redirect_to home_path
  	else
  		redirect_to "/login", alert: "You have entered the wrong username and/or password."
  	end
  end

  def destroy
  	logout
  	redirect_to "/"
  end
end
