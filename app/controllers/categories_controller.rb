class CategoriesController < ApplicationController
  before_action :logged_in?, only: [:new]
  def new
    @category = Category.new
    eventId = params[:id]
    @event = Event.find_by_id(eventId)
  end

  def create
    categoryParams = params.require(:category).permit(:title, :description)
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

  def edit
  end

  def index
  end

  def delete
  end
end
