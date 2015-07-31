class NotifierPreview < ActionMailer::Preview
  def digest
    options = {
      recipients: User.all.pluck(:email),
      completed_todos: {List.last => [Item.first, Item.last]},
      completed_amount: 2,
      remaining_amount: 8
    }

    @daily_statistic = DailyProgressDigest.new options
    Notifier.digest @daily_statistic
  end
end