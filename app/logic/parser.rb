class Parser

  def initialize query
    @query = query
  end

  def perform
    { status: status, author: author, phrase: query.strip }
  end

  private

  attr_reader :query

  def status
    status_regex = /\bis\s*:\s*(\w+)/
    match = keyword_value status_regex

    return true if match == 'done'
    false if match == 'todo'
  end

  def author
    author_regex = /\bauthor\s*:\s*(\S+)/
    keyword_value author_regex
  end

  def keyword_value regex
    match = query.match(regex)[1]
    query.gsub! regex, ''

    match
  end

end