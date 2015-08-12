class ToDoListsController < ApplicationController

  def index
    @lists_per_page = Finder.new(cookies[:filter]).perform
    @lists_per_page = @lists_per_page.paginate(page: params[:page])
    @lists_presentation = ListsPresentation.new @lists_per_page

    @lists = @lists_per_page.map { |list| SingleListPresenter.new list }
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