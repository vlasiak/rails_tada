class Pager

  def info
    { per_page: per_page, on_page: on_page }
  end

  private

  def per_page
    List.per_page
  end

  def on_page
    total = List.count
    total.div(per_page) + 1
  end

end