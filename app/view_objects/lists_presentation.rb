class ListsPresentation

  def initialize user, lists
    @user = user
    @lists = lists
  end

  def partial
    return 'no_matches' if lists.blank?
    return 'lists' if user.lists.present?
    'no_lists'
  end

  private

  attr_reader :user, :lists
end