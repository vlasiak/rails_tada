class DailyProgressDigest

  def initialize params
    @params = params
  end

  def all_items_completed?
    params[:remaining] == 0
  end

  def no_items_done?
    params[:completed] == 0
  end

  def completed_number
    params[:completed]
  end

  def remaining_number
    params[:remaining]
  end

  def for_today
    date = Date.today
    date.strftime I18n.t 'formats.email_digest_date'
  end

  def recipients
    params[:recipients]
  end

  private

  attr_reader :params

end