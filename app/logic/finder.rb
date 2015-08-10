class Finder

  def initialize options
    @options = Parser.new(options).perform
  end

  def perform
    @query = find_all
    @query = filter_by_author if options[:author]
    @query = filter_by_phrase if options[:phrase].present?
    @query = filter_by_status unless options[:status].nil?

    @query
  end

  private

  attr_reader :options, :query

  def find_all
    List.including_items.with_creator
  end

  def filter_by_author
    query.where(users: {email: options[:author]})
  end

  def filter_by_phrase
    query.joins(:items).where('items.text ILIKE ?', "%#{options[:phrase]}%")
  end

  def filter_by_status
    query.where(items: {done: options[:status]})
  end

end