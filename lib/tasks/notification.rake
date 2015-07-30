namespace :notification do
  desc 'TODO'
  task send_digest: :environment do
    completed = Item.completed_today.count
    remaining = Item.incompleted.count

    statistic = Hash(completed: completed, remaining: remaining)

    daily_statistic = DailyStatisticNotifier.new statistic
    Notifier.statistic(daily_statistic).deliver
  end
end
