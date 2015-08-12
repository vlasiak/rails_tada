class Parser

  def initialize query
    @status_regex = /\bis\s*:\s*(\w+)/i
    @author_regex = /\bauthor\s*:\s*(\S+)/i
    @query = query || ''
  end

  def perform
    { status: status, author: author, phrase: query.strip }
  end

  private

  attr_reader :status_regex, :author_regex, :query

  def status
    return unless status_present?

    match = keyword_value(status_regex)
    return true if match.downcase == 'done'
    false if match.downcase == 'todo'
  end

  def author
    keyword_value(author_regex) if author_present?
  end

  def status_present?
    query =~ status_regex
  end

  def author_present?
    query =~ author_regex
  end

  def keyword_value regex
    match = query.match(regex)[1]
    query.gsub! regex, ''

    match
  end

end