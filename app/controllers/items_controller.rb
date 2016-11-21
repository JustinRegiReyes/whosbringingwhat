class ItemsController < ApplicationController
  before_action :logged_in?
  def new
    @event = Event.find_by_id(params[:event_id])
    @category = Category.find_by_id(params[:category_id])
    @item = Item.new
  end

  def create
    category = Category.find_by_id(category_id)
    item = Item.create(item_params)
    category.items << item
    current_user.items << item
    flash[:success] = "Item signed up"
    redirect_to "/events/#{event_id}"
  end

  def show
  end

  def edit
    @item = Item.find_by_id(item_id)
    @event = Event.find_by_id(event_id)
  end

  def update
    item = Item.find_by_id(item_id)
    item.update(item_params)
    flash[:success] = "Item udpdated"
    redirect_to :back
  end

  def bringingIndex
    @items = current_user.items
  end

  def event_show
    @item = Item.find_by_id(params[:item_id])
    @event = Event.find_by_id(params[:event_id])
  end

  def delete
  end

  def my_items
    @items = current_user.items
  end

  private 

  def item_id
    params[:id]
  end

  def event_id
    params[:event_id]
  end

  def category_id
    params[:category_id]
  end

  def item_params
    params.require(:item).permit(:title, :description)
  end
end
