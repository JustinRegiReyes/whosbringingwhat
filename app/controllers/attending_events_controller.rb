class AttendingEventsController < ApplicationController
  def accept
  	respond_to do |format|
	  	ae = AttendingEvent.find_by_id(params[:id])
	  	ae.update({going: true, undecided: false})
	  	what_kind = ae.as_json.key(true)
	  	notification_invitation_status(ae.id, what_kind)
		flash[:success] = "Accepted invitation"
		format.html { render layout: false }
		format.json { render :json => {data: "success" }, status: 200 }
	end
	mark_notification_read(notification_id)
  end

  def declined
  	respond_to do |format|
	  	ae = AttendingEvent.find_by_id(params[:id])
	  	ae.update({going: true, undecided: false})
	  	what_kind = ae.as_json.key(true)
	  	notification_invitation_status(ae.id, what_kind)
		flash[:success] = "Declined invitation"
		format.html { render layout: false }
		format.json { render :json => {data: "success" }, status: 200 }
	end
	mark_notification_read(notification_id)
  end

  def maybe
  	respond_to do |format|
	  	ae = AttendingEvent.find_by_id(params[:id])
	  	ae.update({going: true, undecided: false})
	  	what_kind = ae.as_json.key(true)
	  	notification_invitation_status(ae.id, what_kind)
		flash[:success] = "Marked maybe"
		format.html { render layout: false }
		format.json { render :json => {data: "success" }, status: 200 }
	end
	mark_notification_read(notification_id)
  end

  private

  def notification_id
  	params[:notification_id]
  end
end
