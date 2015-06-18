class ToDoListsController < ApplicationController
  def index
    @lists = List.including_items
  end
end
