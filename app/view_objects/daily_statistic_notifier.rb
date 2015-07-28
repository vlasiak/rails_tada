class DailyStatisticNotifier

  def initialize
    @a = 4
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

end