class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  include SessionsHelper
  include ItemsHelper
  include NotificationsHelper
  include FriendshipsHelper
  include EventsHelper
  include CategoriesHelper

  def catch_route
      redirect_to "/"
  end
end
