class ListsPresentation

  def initialize lists
    @lists = lists
  end

  def partial
    return 'no_matches' if lists.blank?
    return 'lists' unless List.count.zero?
    'no_lists'
  end

  private

  attr_reader :lists
end