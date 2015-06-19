class ToDoItemsController < ApplicationController

  def new
  end

  def create
    @list = List.find params[:id]
    item = @list.items.new(item_params)

    respond_to do |format|
      if item.save!
        format.html { redirect_to to_do_lists_path, notice: 'List item was successfully created.' }
        format.js { @current_item = item }
      # else
      #   format.html { render :new }
      end
    end

  end

  private

  def item_params
    params.require(:item).permit(:text)
  end
end
