namespace :notification do
  desc 'TODO'
  task send_digest: :environment do
    completed = Item.where('updated_at >= ? AND updated_at <= ?',
      Date.today.to_time.beginning_of_day,
      Date.today.to_time.end_of_day).count
    remaining = Item.where(done: false).count

    statistic = Hash(completed: completed, remaining: remaining)

    daily_statistic = DailyStatisticNotifier.new statistic
    Notifier.statistic(daily_statistic).deliver
  end
end
