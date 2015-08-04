namespace :notification do
  desc 'TODO'
  task send_digest: :environment do
    while true
      DailyDigest.new.perform
      sleep 5.minutes
    end
  end
end
