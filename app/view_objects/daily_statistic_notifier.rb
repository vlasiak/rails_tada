class DailyStatisticNotifier

  def initialize
    @a = 7
    @b = 2
  end

  def all_items_completed?
    @b == 0
  end

  def no_items_done?
    @a == 0
  end

  def completed_number
    @a
  end

  def remaining_number
    @b
  end

  def for_yesterday
    date = Date.yesterday
    date.strftime I18n.t 'formats.email_digest_date'
  end

end