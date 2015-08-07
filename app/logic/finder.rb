class Finder

  def initialize options
    @options = Parser.new(options).perform

    @lists = Arel::Table.new(:lists)
    @users = Arel::Table.new(:users)
    @items = Arel::Table.new(:items)
  end

  def perform
    @query = find_all
    filter_by_author if options[:author]
    filter_by_phrase if options[:phrase]
    filter_by_status unless options[:status].nil?

    ActiveRecord::Base.connection.execute query.to_sql
  end

  private

  attr_reader :options, :query, :lists, :users, :items

  def find_all
    items.project(Arel.sql('*')).
    join(lists).on(lists[:id].eq(items[:list_id])).
    join(users).on(users[:id].eq(lists[:user_id]))
  end

  def filter_by_author
    query.where(users[:email].eq(options[:author]))
  end

  def filter_by_phrase
    query.where(items[:text].matches(options[:phrase]))
  end

  def filter_by_status
    query.where(items[:done].eq(options[:status]))
  end

end