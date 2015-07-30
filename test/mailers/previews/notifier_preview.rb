class NotifierPreview < ActionMailer::Preview
  def digest
    recipients = User.all.map {|user| user.email}
    params = Hash(recipients: recipients, completed: 0, remaining: 3)
    @daily_statistic = DailyProgressDigest.new params
    Notifier.digest @daily_statistic
  end
end