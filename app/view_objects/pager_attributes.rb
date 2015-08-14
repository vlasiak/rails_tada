class PagerAttributes

  def initialize amount
    @total_amount = amount
  end

  def per_page
    List.per_page
  end

  def on_page
    total_amount.div(per_page) + 1
  end

  private

  attr_reader :total_amount

end