class ToDoItemsController < ApplicationController
  def create
    list = List.find params[:id]
    @item = list.items.new item_params

    @result = @item.save
    @current_item = @item
  end

  private

  def item_params
    params.require(:item).permit(:text)
  end
end
