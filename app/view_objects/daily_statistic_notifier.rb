class DailyStatisticNotifier

  def initialize statistic
    @completed = statistic[:completed]
    @remaining = statistic[:remaining]
  end

  def all_items_completed?
    remaining == 0
  end

  def no_items_done?
    completed == 0
  end

  def completed_number
    completed
  end

  def remaining_number
    remaining
  end

  def for_today
    date = Date.today
    date.strftime I18n.t 'formats.email_digest_date'
  end

  private

  attr_reader :completed, :remaining

end