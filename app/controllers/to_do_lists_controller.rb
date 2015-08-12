class ToDoListsController < ApplicationController

  def index
    @lists_per_page = List.including_items.with_creator.paginate(page: params[:page])
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

  def search
    matched_lists = Finder.new(params[:search]).perform
    @lists = matched_lists.map { |list| SingleListPresenter.new list }
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end

end