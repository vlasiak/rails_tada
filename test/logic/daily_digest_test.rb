require 'test_helper'

class DailyDigestTest < ActionMailer::TestCase
  fixtures :lists
  fixtures :items

  def setup
    @digest = DailyDigest.new
  end

  test "should return statistic" do
    list = lists(:first)

    digest.expects(:completed_for_today).returns(list.items.completed)
    digest.perform

    assert_equal ({
       :recipients => ['vasyll@tada.com'],
       :completed_todos => {
           list => [items(:third), items(:second)]
       },
       :completed_amount => 2,
       :remaining_amount => 2
    }), digest.statistic
  end

  test "email has been sent" do
    digest.perform

    refute ActionMailer::Base.deliveries.empty?
  end

  private

  attr_reader :digest

end
