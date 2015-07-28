class NotifierPreview < ActionMailer::Preview

  def statistic
    @daily_statistic = DailyStatisticNotifier.new
    Notifier.statistic @daily_statistic
  end

end