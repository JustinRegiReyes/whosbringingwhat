class CalendarController < ApplicationController
  def index
  end

  def events
  	require 'json'
  	user = User.find_by_id(1)
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
