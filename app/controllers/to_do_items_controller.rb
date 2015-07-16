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

    if item.done?
      item.remove_from_list
    else
      item.move_to_bottom
    end

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