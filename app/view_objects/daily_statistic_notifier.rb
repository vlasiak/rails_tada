class DailyStatisticNotifier

  def initialize statistic
    @completed_todos = statistic[:completed_todos]
    @completed_amount = statistic[:completed_amount]
    @remaining_amount = statistic[:remaining_amount]
  end

  def all_items_completed?
    remaining_amount == 0
  end

  def no_items_done?
    completed_amount == 0
  end

  def completed_number
    completed_amount
  end

  def remaining_number
    remaining_amount
  end

  def for_today
    date = Date.today
    date.strftime I18n.t 'formats.email_digest_date'
  end

  private

  attr_reader :completed_amount, :remaining_amount

end