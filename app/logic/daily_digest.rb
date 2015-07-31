class DailyDigest

  def perform
    options = get_statistic
    daily_statistic = DailyProgressDigest.new options

    Notifier.digest(daily_statistic).deliver
  end

  private

  def get_statistic
    completed = completed_for_today

    {
      recipients: get_recipients,
      completed_todos: completed.group_by { |item| item.list },
      completed_amount: completed.size,
      remaining_amount: incompleted
    }
  end

  def get_recipients
    User.all.pluck :email
  end

  def completed_for_today
    Item.with_list.completed_today
  end

  def incompleted
    Item.incompleted.count
  end

end