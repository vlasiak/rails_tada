require 'test_helper'

class NotifierTest < ActionMailer::TestCase
  fixtures :lists

  def setup
    list = lists(:first)

    options = {
      recipients: ['vasyll@tada.com'],
      completed_todos: {list => list.items},
      completed_amount: 4,
      remaining_amount: 5
    }

    @daily_statistic = DailyProgressDigest.new options
    @mail = Notifier.digest @daily_statistic
  end

  test "email headers" do
    assert_equal "TaDa Daily Digest for #{@daily_statistic.for_today}", mail.subject
    assert_equal ['vasyll@tada.com'], mail.to
    assert_equal ['no-reply@tada.com'], mail.from
  end

  test "email body contains statistic" do
    assert_match /4 todos completed./, mail.body.encoded
    assert_match /5 todos remaining./, mail.body.encoded
  end

  test "email body contains completed items details" do
    mail.deliver

    assert_select_email do
      assert_select 'ul' do |element|
        assert_select element, 'li', 4
      end
    end
  end

  private

  attr_reader :mail

end
