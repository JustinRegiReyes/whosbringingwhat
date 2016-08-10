class CommentsController < ApplicationController
  def index
  end

  def create
    comment = Comment.new({post: create_params[:post]})
    if true
      # event = get_event(create_params[:id])
      # event.comments << comment
      respond_to do |format|
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
    params.require(:comments).permit(:id, :post)
  end

  def get_event(id)
    Event.find_by_id(id)
  end
end
