class NotifierPreview < ActionMailer::Preview
  def digest
    list = List.last

    options = {
        recipients: User.all.pluck(:email),
        completed_todos: {list => list.items.completed},
        completed_amount: 2,
        remaining_amount: 3
    }
    p options
    @daily_statistic = DailyProgressDigest.new options
    Notifier.digest @daily_statistic
  end
end