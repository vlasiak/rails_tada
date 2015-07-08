class ListsPresentation

  def initialize lists
    @lists = lists
  end

  def all
    return 'no_lists' if lists.blank?
    'lists'
  end

  private

  attr_reader :lists
end