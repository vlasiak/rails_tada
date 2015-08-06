class Parser

  def initialize query
    @query = query
  end

  def perform
    q = query
    status_regex = /(\b)is\s*:\s*(\w+)/
    author_regex = /(\b)author\s*:\s*(\S+)/
    s = q.match(status_regex)[2]
    q = q.sub(status_regex, '\1')
    author = query.match(author_regex)[2]
    q = q.sub(author_regex, '\1')
    phrase = q.strip

    { status: status(s), author: author, phrase: phrase }
  end

  private

  attr_reader :query

  def status patern
    return true if patern == 'done'
    false if patern == 'todo'
  end

end