class Filter

  def initialize options
    @options = options
  end

  def perform
    List.
      including_items.
      with_creator.
      created_by(options[:author]).
      find_items(options[:phrase]).
      with_status(options[:status])
  end

  private

  attr_reader :options

end