class CommentsController < ApplicationController
  before_action :logged_in?
  def index
  end

  def create
    if params[:comments] != nil
      eventId = create_params[:event_id]
      comment = Comment.new({post: create_params[:post], event_id: eventId, user_id: current_user.id})
      if comment.save
        respond_to do |format|
          flash[:success] = "Comment added"
          format.html { redirect_to("/events/#{create_params[:event_id]}") }
          format.json { render :json => {comment: comment.post} }
        end
      else
        respond_to do |format|
          flash[:error] = "Error adding comment"
          format.json { render :json => {comment: comment.post}, status: 422 }
        end
      end
    end
  end

  def destroy
    commentId = params[:id]
    comment = Comment.find_by_id(commentId)
    comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to :back
  end

  private

  def create_params
    if params[:comments] != nil
      comment_params = params.require(:comments).permit(:post)
      comment_params[:event_id] = params[:id]
      return comment_params
    end
  end

  def get_event(id)
    Event.find_by_id(id)
  end
end
