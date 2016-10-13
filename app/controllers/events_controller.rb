class EventsController < ApplicationController
  before_action :logged_in?, except: [:show]

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
    @event = Event.new(event_params)
    if @event.save
      flash[:success] = "Created event"
      current_user.created_events << @event
      create_categories(categories_params, @event.id, current_user.id)
      redirect_to "/events/#{@event.id}"
    else
      if categories_params.first[:title].empty? == false
        @categories = categories_params
      end
      render "/events/new"
    end
  end

  def show
    @event = Event.find_by_id(event_id)
  end

  def edit
    @event = Event.find_by_id(event_id)
  end

  def update
    event = Event.find_by_id(event_id)
    event.update(update_params)
    flash[:success] = "Changes saved"
    redirect_to "/events/#{event.id}/edit"
  end

  def photo_crop
    @event = Event.find_by_id(event_id)
  end

  def update_photo_crop
    event = Event.find_by_id(event_id)
    event.update(photo_crop_params)
    flash[:success] = "Updated event photo"
    redirect_to "/events/#{event.id}/edit"
  end

  def banner_crop
    @event = Event.find_by_id(event_id)
  end

  def update_banner_crop
    event = Event.find_by_id(event_id)
    event.update(banner_crop_params)
    flash[:success] = "Updated event banner"
    redirect_to "/events/#{event.id}/edit"
  end

  def created
    @events = current_user.events
  end

  def search
    eventQuery = params[:event]
    if eventQuery.present?
      searchKey = eventQuery[:search_key]
      dateStart = eventQuery[:date_start]
      username = eventQuery[:username]
      if username.present? 
        user = User.where("username ILIKE ?", eventQuery[:username]).first
        if(user != nil)
            @events = user.created_events.where("search_key ILIKE ?", searchKey).by_date_start(dateStart)
        end
      end
      @username = user != nil ? user.username : eventQuery[:username]
      @search_key = searchKey
      @date_start = dateStart
    end
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

  def destroy
    event = Event.find_by_id(event_id)
    categories_delete_items(event.categories)
    event.categories.delete_all
    event.comments.delete_all
    event.attending_events.delete_all
    event.destroy
    flash[:success] = "Event deleted"
    redirect_to "/my_events"
  end

  def guests
    respond_to do |format|
        format.json { render :json => {specific_guests: specific_guests, all_guests: all_guests}, status: 200 }
    end
  end

  def my_events
    @events = current_user.created_events
  end

  def send_invites
    invites = send_invites_to_users(invited_guests, event_id)
    if invites
      respond_to do |format|
          flash[:success] = "Invitations sent"
          format.json { render :json => {data: "success"}, status: 200 }
      end
      invitation_notifications(invites)
    else
      respond_to do |format|
          flash[:error] = "Invitations not sent"
          format.json { render :json => {data: "error"}, status: 422 }
      end
    end
  end

  def invitation_response
    ae = AttendingEvent.find_by_id(attending_event_id)
    update_attending_event(ae)
  end

  private

  def update_params
    updated_params = params.require(:event).permit(:photo, :banner, :title, :description, :where, :address, :city, :zipcode, :state, :country, :date_start, :date_end, :time_start, :time_end, :search_key, :highlights)
    if updated_params[:date_start].length > 0
      updated_params[:date_start] = Date.strptime(updated_params[:date_start], '%m/%d/%Y')
    end
    if updated_params[:date_end].length > 0
      updated_params[:date_end] = Date.strptime(updated_params[:date_end], '%m/%d/%Y')
    end
    return updated_params
  end

  def event_params
      edited_params = params.require(:event).permit(:photo, :banner, :title, :description, :where, :address, :city, :zipcode, :state, :country, :date_start, :date_end, :time_start, :time_end, :search_key, :highlights)
      if edited_params[:date_start].length > 0
        edited_params[:date_start] = Date.strptime(edited_params[:date_start], '%m/%d/%Y')
      end
      if edited_params[:date_end].length > 0
        edited_params[:date_end] = Date.strptime(edited_params[:date_end], '%m/%d/%Y')
      end
      return edited_params
  end

  def categories_params
      params.require(:categories)
  end

  def specific_guests
    eventId = params[:id]
    type = params[:type]
    if type == "invited"
      guests =  User.joins(:attending_events).where({attending_events: {event_id: eventId}}).as_json(:only => [:id,:username], methods: [:avi_url])
    else
      attending_events_hash = Hash["event_id", eventId, type, true]
      guests =  User.joins(:attending_events).where({attending_events: attending_events_hash}).as_json(:only => [:id,:username], methods: [:avi_url])
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

  def invited_guests
    params[:invitedGuests]
  end

  def event_id
      params[:id]
  end

  def attending_event_id
    params[:attending_event_id]
  end

  def photo_crop_params
    params.require(:event).permit(:photo_crop_x, :photo_crop_y, :photo_crop_w, :photo_crop_h)
  end

  def banner_crop_params
    params.require(:event).permit(:banner_crop_x, :banner_crop_y, :banner_crop_w, :banner_crop_h)
  end
end
