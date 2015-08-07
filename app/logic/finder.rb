class Finder

  def initialize options
    @options = Parser.new(options).perform
  end

  def perform
    query = List.with_creator.including_items
    query = query.created_by(options[:author]) if options[:author]
    query = query.find_items(options[:phrase]) if options[:phrase]
    query = query.with_status(options[:status]) unless options[:status].nil?
    query
  end

  private

  attr_reader :options

end