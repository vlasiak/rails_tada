require 'test_helper'

class NotifierTest < ActionMailer::TestCase

  def setup
    recipients = User.all.map {|user| user.email}
    params = Hash(recipients: recipients, completed: 0, remaining: 5)
    @daily_statistic = DailyProgressDigest.new params
    @mail = Notifier.digest @daily_statistic
  end

  test "email headers" do
    assert_equal "TaDa Daily Digest for #{@daily_statistic.for_today}", mail.subject
    assert_equal ['vasyll@tada.com'], mail.to
    assert_equal ['no-reply@tada.com'], mail.from
  end

  test "email body" do
    assert_match /Nothing was done today./, mail.body.encoded
    assert_match /5 todos remaining./, mail.body.encoded
  end

  private

  attr_reader :mail

end
