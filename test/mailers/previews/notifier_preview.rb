class NotifierPreview < ActionMailer::Preview
  def digest
    options = {
      recipients: ['vasyllasiak@interlink-ua.com'],
      completed_todos: {List.last => [Item.first, Item.last]},
      completed_amount: 2,
      remaining_amount: 8
    }

    @daily_statistic = DailyProgressDigest.new options
    Notifier.digest @daily_statistic
  end
end