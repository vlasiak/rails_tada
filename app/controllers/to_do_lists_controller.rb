class ToDoListsController < ApplicationController

  def index
    all_lists = List.including_items.with_creator
    @lists_presentation = ListsPresentation.new all_lists

    @lists = all_lists.map { |list| SingleListPresenter.new list }
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
    @search = List.search(include: [:items, :user]) do
      fulltext 'basecamp' do
        fields(:title, :items)
      end
    end

    render json: @search.results
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end

end