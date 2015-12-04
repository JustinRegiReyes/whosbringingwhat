class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    eventParams = params.require(:event).permit(:title, :description, :date, :time, :where)
    event = Event.create(eventParams)
    attendingEvent = AttendingEvent.create()
    event.attending_event = attendingEvent
    current_user.events << event
    
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
end
