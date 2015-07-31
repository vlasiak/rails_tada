class DailyDigest

  def perform
    options = get_statistic
    daily_statistic = DailyProgressDigest.new options

    Notifier.digest(daily_statistic).deliver
  end

  private

  def get_statistic
    recipients = get_recipients
    completed = completed_amount
    remaining = incompleted_amount

    { recipients: recipients, completed: completed, remaining: remaining }
  end

  def get_recipients
    User.all.pluck :email
  end

  def completed_amount
    Item.completed_today.count
  end

  def incompleted_amount
    Item.incompleted.count
  end

end