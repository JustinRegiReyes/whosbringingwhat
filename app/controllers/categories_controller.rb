class CategoriesController < ApplicationController
  before_action :logged_in?, only: [:new]
  def new
    @category = Category.new
    eventId = params[:id]
    @event = Event.find_by_id(eventId)
  end

  def create
    categoryParams = params.require(:category).permit(:title, :needed, :description)
    eventId = params[:event_id]
    event = Event.find_by_id(eventId)
    category = Category.create(categoryParams)
    event.categories << category

    redirect_to "/events/#{event.id}"
  end

  def show
    @category = Category.find_by_id(params[:category_id])
    @event = @category.event
  end

  def in_event_edit
    @event = Event.find_by_id(event_id)
  end

  def edit
  end

  def index
  end

  def delete
  end

  private

  def event_id
    params[:event_id]
  end
end
