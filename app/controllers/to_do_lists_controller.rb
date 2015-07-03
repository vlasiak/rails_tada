class ToDoListsController < ApplicationController

  def index
    @lists = List.including_items
  end

  def new
    @list = List.new

    render partial: 'new'
  end

  def create
    @list = List.new list_params
    @list.save
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end

end