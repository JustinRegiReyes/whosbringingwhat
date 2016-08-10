class CommentsController < ApplicationController
  before_action :logged_in?
  def index
  end

  def create
    comment = Comment.new({post: create_params[:post]})
    if comment.save
      event = get_event(create_params[:event_id])
      current_user.comments << comment
      event.comments << comment
      respond_to do |format|
        format.html { redirect_to("/events/#{create_params[:event_id]}") }
        format.json { render :json => {comment: comment.post} }
      end
    else
      respond_to do |format|
        format.json { render :json => {comment: comment.post}, status: 422 }
      end
    end
  end

  private

  def create_params
    comment_params = params.require(:comments).permit(:post)
    comment_params[:event_id] = params[:id]
    return comment_params
  end

  def get_event(id)
    Event.find_by_id(id)
  end
end
