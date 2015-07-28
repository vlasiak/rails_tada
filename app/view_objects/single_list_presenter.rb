class SingleListPresenter

  def initialize list
    @list = list
  end

  def id
    list.id
  end

  def title
    list.title
  end

  def description
    list.description
  end

  def created_on
    date = list.created_at
    date.strftime I18n.t 'formats.list_creation_date'
  end

  def created_by
    list.user.email
  end

  def persisted?
    list.persisted?
  end

  def has_items?
    list.items.present?
  end

  def incompleted_items
    incompleted_items = list.items.reject { |item| item.done? }
    incompleted_items.sort_by { |item| item.position }
  end

  def completed_items
    completed_items = list.items.select { |item| item.done? }
    completed_items.sort_by { |item| item.updated_at }
  end

  private

  attr_reader :list

end