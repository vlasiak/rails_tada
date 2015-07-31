class DailyProgressDigest

  def initialize options
    @options = options
  end

  def all_items_completed?
    options[:remaining_amount] == 0
  end

  def no_items_done?
    options[:completed_amount] == 0
  end

  def completed_number
    options[:completed_amount]
  end

  def remaining_number
    options[:remaining_amount]
  end

  def for_today
    date = Date.today
    date.strftime I18n.t 'formats.email_digest_date'
  end

  def recipients
    options[:recipients]
  end

  def completed_todos
    options[:completed_todos]
  end

  private

  attr_reader :options

end