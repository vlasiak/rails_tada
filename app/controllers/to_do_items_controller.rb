class ToDoItemsController < ApplicationController

  def new
    # list = List.find params[:id]
    # @item = list.items.new item_params
  end

  def create
    list = List.find params[:id]
    @item = list.items.new item_params

    @item.save
  end

  private

  def item_params
    params.require(:item).permit(:text)
  end

end
