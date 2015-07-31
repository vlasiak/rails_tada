class DailyProgressDigest

  def initialize options
    @options = options
  end

  def all_items_completed?
    options[:remaining] == 0
  end

  def no_items_done?
    options[:completed] == 0
  end

  def completed_number
    options[:completed]
  end

  def remaining_number
    options[:remaining]
  end

  def for_today
    date = Date.today
    date.strftime I18n.t 'formats.email_digest_date'
  end

  def recipients
    options[:recipients]
  end

  private

  attr_reader :options

end