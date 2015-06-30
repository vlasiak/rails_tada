class ToDoItemsController < ApplicationController

  def new
    list = List.find params[:id]
    @item = list.items.new

    render partial: 'new'
  end

  def create
    @item = Item.new item_params
    @item.save
  end

  def update
    item = Item.find params[:id]
    item.update_attribute 'done', !item.done
    render plain: item.inspect
  end

  private

  def item_params
    params.require(:item).permit(:text, :list_id)
  end

end