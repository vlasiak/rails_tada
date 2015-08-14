class ListsPresentation

  def initialize lists_exist, lists
    @lists_exist = lists_exist
    @lists = lists
  end

  def partial
    return 'no_lists' unless lists_exist
    return 'no_matches' if lists.blank?
    'lists'
  end

  private

  attr_reader :lists_exist, :lists
end