class EventsController < ApplicationController
  before_action :logged_in?, only: [:new, :show, :created, :attending]

  def new
    @event = Event.new
  end

  def find
    eventParams = params.require(:event)
    title = eventParams[:title]
    date = eventParams[:date]
    user = User.find_by_username(eventParams[:username])

    if user 
      event = Event.find_by(user_id: user.id, title: title, date: date)
    else
      return redirect_to :back, alert: "An event does not match those queries."
    end 

    if event
      return redirect_to "/events/#{event.id}"
    else
      return redirect_to :back, alert: "An event does not match those queries."
    end
  end

  def create
    event = Event.create(event_params)
    current_user.created_events << event
    redirect_to "/events/#{event.id}"
  end

  def show
    eventId = params[:id]
    @event = Event.find_by_id(eventId)
  end

  def edit
  end

  def created
    @events = current_user.events
  end

  def search
    eventQuery = params[:event]
    user = User.where("username ILIKE ?", eventQuery[:username]).first
    if(user != nil)
      @events = user.created_events.where("title ILIKE ?", "#{eventQuery[:title]}")
    end
    @username = user != nil ? user.username : eventQuery[:username]
    @title = eventQuery[:title]
  end

  def attending
    eventId = params[:id]
    event = Event.find_by_id(eventId)
    attendingEvent = event.attending_event
    #only have to push user into attendingEvent
    #users attending_events get populated as well by doing so
    attendingEvent.users << current_user
    redirect_to "/events/#{eventId}"
  end

  def attendingIndex
    @attendingEvents = current_user.attending_events
  end

  def index
  end

  def delete
  end

  def guests
    respond_to do |format|
        format.json { render :json => {specific_guests: specific_guests, all_guests: all_guests}, status: 200 }
    end
  end

  def my_events
    
  end

  private

  def event_params
      params.require(:event).permit(:photo, :title, :description, :where, :address, :city, :zipcode, :state, :country, :date_start, :date_end, :time_start, :time_end)
  end

  def specific_guests
    eventId = params[:id]
    type = params[:type]
    if type == "invited"
      guests =  User.joins(:attending_events).where({attending_events: {event_id: eventId}}).as_json(:only => [:id,:username], methods: [:avi_url])
    else
      guests =  User.joins(:attending_events).where({attending_events: {event_id: eventId, "#{type}": true}}).as_json(:only => [:id,:username], methods: [:avi_url])
    end

    return guests
  end

  def all_guests
    eventId = params[:id]
    guests = User.joins(:attending_events).where({attending_events: {event_id: eventId }})
    # goes through each guest and assigns it an attending_event related to the event asking for the guests
    # the attending_event is then set to the users :event_target virtual attr
    guests.each do |guest|
      guest.event_target = guest.attending_events.find_by({event_id: eventId, user_id: guest.id})
    end

    # returns the guests as json objects in an array with only certain attrs and methods
    return guests.as_json(:only => [:id,:username], methods: [:avi_url, :attendance_status])
  end
end
