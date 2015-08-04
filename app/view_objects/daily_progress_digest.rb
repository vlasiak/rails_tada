class DailyProgressDigest

  def initialize options
    @options = options
  end

  def all_items_completed?
    remaining_number.zero?
  end

  def no_items_done?
    completed_number.zero?
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