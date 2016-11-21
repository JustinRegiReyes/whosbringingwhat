class CalendarController < ApplicationController
  before_action :logged_in?
  
  def index
  end

  def events
  	require 'json'
  	user = current_user
  	events = user.created_events + user.going_tos
  	bestEve = []
  	events.each do |event|
  		event.owner = event.user
  		# setting a date key for clndr.js consumption
  		event.date = event.date_start
  	end

  	render json: events, methods: [:owner, :date]
  end
end
