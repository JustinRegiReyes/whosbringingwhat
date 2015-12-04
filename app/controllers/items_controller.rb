class ItemsController < ApplicationController
  def new
    @event = Event.find_by_id(params[:event_id])
    @item = Item.new
  end

  def create
    itemParams = params.require(:item).permit(:title, :description)
    category = Category.find_by_id(params[:categories])
    eventId = params[:event_id]
    item = Item.create(itemParams)
    category.items << item
    current_user.items << item
    redirect_to "/events/#{eventId}"
  end

  def show
  end

  def edit
  end

  def bringingIndex
  end

  def delete
  end
end
