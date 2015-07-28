require 'test_helper'

class NotifierTest < ActionMailer::TestCase

  test "email headers" do
    mail = Notifier.statistic
    assert_equal 'TaDa daily digest for today', mail.subject
    assert_equal ['isnull29@gmail.com'], mail.to
    assert_equal ['no-reply@tada.com'], mail.from
  end

  test "email body" do
    mail = Notifier.statistic
    assert_match /Notifier#statistic/, mail.body.encoded
  end

end
