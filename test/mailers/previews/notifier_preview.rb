class NotifierPreview < ActionMailer::Preview
  def digest
    recipients = User.all.pluck :email
    options = {recipients: recipients, completed: 0, remaining: 3}
    @daily_statistic = DailyProgressDigest.new options
    Notifier.digest @daily_statistic
  end
end