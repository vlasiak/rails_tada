namespace :notification do
  desc 'TODO'
  task send_digest: :environment do
    DailyDigest.new.perform
  end
end
