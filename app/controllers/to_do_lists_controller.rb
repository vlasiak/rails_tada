class ToDoListsController < ApplicationController

  def index
    lists = Finder.new(cookies[:filter]).perform
    @lists_presentation = ListsPresentation.new lists

    @lists = lists.map { |list| SingleListPresenter.new list }
  end

  def new
    @list = List.new

    render partial: 'new'
  end

  def create
    list = current_user.lists.create list_params
    @list= SingleListPresenter.new list
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end

end