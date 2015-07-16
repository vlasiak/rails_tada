class ToDoItemsController < ApplicationController

  def new
    list = List.find params[:id]
    @item = list.items.new

    render partial: 'new'
  end

  def create
    @item = Item.new item_params
    @item.position = @item.incompleted_count + 1
    @item.save
  end

  def update
    item = Item.find params[:id]

    if item.done?
      item.insert_at item.incompleted_count + 1
    else
      item.move_to_bottom
    end

    item.update_attribute 'done', !item.done
    render json: item
  end

  def move
    @item = Item.find params[:id]
    @item.insert_at params[:position].to_i

    render nothing: true
  end

  private

  def item_params
    params.require(:item).permit(:text, :list_id)
  end

end