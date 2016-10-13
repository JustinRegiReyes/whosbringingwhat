class CategoriesController < ApplicationController
  before_action :logged_in?
  def new
    eventId = params[:event_id]
    @category = Category.new
    @event = Event.find_by_id(eventId)
  end

  def create
    categoryParams = params.require(:category).permit(:title, :needed, :description)
    category = Category.new(categoryParams)
    if category.save
      eventId = params[:event_id]
      event = Event.find_by_id(eventId)
      event.categories << category
      flash[:success] = "Category created"
      redirect_to "/events/#{event.id}/categories/edit"
    else
      render :new
    end

  end

  def show
    @category = Category.find_by_id(category_id)
    @event = @category.event
  end

  def in_event_edit
    @event = Event.find_by_id(event_id)
  end

  def edit
    @category = Category.find_by_id(category_id)
    @event = @category.event
  end

  def update
    category = Category.find_by_id(category_id)
    if category.update(category_params)
      flash[:success] = "Edits saved"
      redirect_to "/events/#{category.event.id}/categories/edit"
    else
      render :edit
    end
  end

  def index
  end

  def delete
    category = Category.find_by_id(category_id)
    category.items.delete_all
    category.destroy
    flash[:success] = "Category deleted"
    redirect_to "/events/#{event_id}/categories/edit"
  end

  private

  def event_id
    params[:event_id]
  end

  def category_id
    params[:category_id]
  end

  def category_params
    params.require(:category).permit(:title, :needed, :description)
  end
end
