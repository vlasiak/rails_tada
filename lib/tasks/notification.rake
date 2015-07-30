namespace :notification do
  desc 'TODO'
  task send_digest: :environment do
    digest = DailyDigest.new
    digest.send
  end
end
