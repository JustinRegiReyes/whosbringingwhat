class AttendingEventsController < ApplicationController
  def accept
  	respond_to do |format|
	  	ae = AttendingEvent.find_by_id(attending_event_id)
	  	ae.update({going: true, undecided: false})
		if params_notification?
			mark_notification_read(notification_id)
		elsif params_notification? == false
			mark_notification_read(current_user.notifications.where({attending_event_id: attending_event_id, read: false}).first.id)
		end
		flash[:success] = "Accepted invitation"
		format.html { render layout: false }
		format.json { render :json => {data: "success" }, status: 200 }
	end
  end

  def decline
  	respond_to do |format|
	  	ae = AttendingEvent.find_by_id(attending_event_id)
	  	ae.update({declined: true, undecided: false})
		if params_notification?
			mark_notification_read(notification_id)
		elsif params_notification? == false
			mark_notification_read(current_user.notifications.where({attending_event_id: attending_event_id, read: false}).first.id)
		end
		flash[:success] = "Declined invitation"
		format.html { render layout: false }
		format.json { render :json => {data: "success" }, status: 200 }
	end
  end

  def maybe
  	respond_to do |format|
	  	ae = AttendingEvent.find_by_id(attending_event_id)
	  	ae.update({maybe: true, undecided: false})
		if params_notification?
			mark_notification_read(notification_id)
		elsif params_notification? == false
			mark_notification_read(current_user.notifications.where({attending_event_id: attending_event_id, read: false}).first.id)
		end
		flash[:success] = "Marked maybe"
		format.html { render layout: false }
		format.json { render :json => {data: "success" }, status: 200 }
	end
  end

  def my_invitations
  	@invitations = current_user.attending_events.where({undecided: true})
  end

  private

  def notification_id
  	params[:notification_id]
  end

  def attending_event_id
  	params[:id]
  end

  def params_notification?
	params.has_key?(:notification)
  end
end
