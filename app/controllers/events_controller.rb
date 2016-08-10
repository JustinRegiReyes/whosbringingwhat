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

  private

  def event_params
      params.require(:event).permit(:photo, :title, :description, :where, :address, :city, :zipcode, :state, :country, :date_start, :date_end, :time_start, :time_end)
  end
end
