class ToDoItemsController < ApplicationController

  def new
    list = List.find params[:id]
    @item = list.items.new

    render partial: 'new'
  end

  def create
    @item = Item.new item_params
    @item.position = @item.list.incompleted_items.size + 1
    @item.save
  end

  def update
    item = Item.find params[:id]

    if item.done
      item.position = item.list.incompleted_items.size + 1
    else
      item.list.items.where('position > ? and done = ?', item.position, false).
          update_all('position = position - 1')
      item.position = nil
    end

    item.update_attribute 'done', !item.done
    render json: item
  end

  def move
    begin
      @item = Item.find params[:id]
      current_list = List.find @item.list_id

      ActiveRecord::Base.transaction do
        if @item.position < params[:position].to_i
          current_list.items.where('position > ? and position <= ? and done = ?', @item.position, params[:position].to_i, false).
            update_all('position = position - 1')
        else
          current_list.items.where('position >= ? and position < ? and done = ?', params[:position].to_i, @item.position, false).
            update_all('position = position + 1')
        end
        @item.update_attribute(:position, params[:position])
      end
    rescue
      @error = true
    end
  end

  private

  def item_params
    params.require(:item).permit(:text, :list_id)
  end

end