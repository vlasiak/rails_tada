class ToDoListsController < ApplicationController
  def index
    @lists = List.includes(:items).all
  end
end
