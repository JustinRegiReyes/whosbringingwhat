class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def create
    eventParams = params.require(:event).permit(:title, :description, :date, :time, :where)
    event = Event.create(eventParams)
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
  end

  def index
  end

  def delete
  end
end
