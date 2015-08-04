class DailyDigest

  attr_reader :statistic

  def perform
    options = gather_statistic
    daily_statistic = DailyProgressDigest.new options

    Notifier.digest(daily_statistic).deliver
  end

  private

  def gather_statistic
    completed = completed_for_today

    @statistic = {
      recipients: get_recipients,
      completed_todos: completed.group_by(&:list),
      completed_amount: completed.size,
      remaining_amount: incompleted_amount
    }
  end

  def get_recipients
    User.all.pluck :email
  end

  def completed_for_today
    Item.completed_today.with_list.ordered
  end

  def incompleted_amount
    Item.incompleted.count
  end

end