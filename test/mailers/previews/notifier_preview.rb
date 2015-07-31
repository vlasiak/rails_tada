class NotifierPreview < ActionMailer::Preview
  def digest
    options = {
        recipients: User.all.pluck(:email),
        completed_todos: {},
        completed_amount: 0,
        remaining_amount: 3
    }

    @daily_statistic = DailyProgressDigest.new options
    Notifier.digest @daily_statistic
  end
end