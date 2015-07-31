require 'test_helper'

class DailyProgressDigestTest < ActiveSupport::TestCase

  def setup
    recipients = User.all.pluck :email
    options = {recipients: recipients, completed: 0, remaining: 5}
    @daily_statistic = DailyProgressDigest.new options
  end

  test "not all items have been completed yet" do
    refute daily_statistic.all_items_completed?
  end

  test "no items have been done for today" do
    assert daily_statistic.no_items_done?
  end

  test "number of completed items for today" do
    assert_equal 0, daily_statistic.completed_number
  end

  test "number of remaining items" do
    assert_equal 5, daily_statistic.remaining_number
  end

  test "digest date format" do
    today = Date.today
    assert_equal today.strftime(I18n.t 'formats.email_digest_date'), daily_statistic.for_today
  end

  test "digest recipients" do
    assert_equal ['vasyll@tada.com'], @daily_statistic.recipients
  end

  private

  attr_reader :daily_statistic
end
