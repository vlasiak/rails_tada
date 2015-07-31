require 'test_helper'

class DailyDigestTest < ActionMailer::TestCase

  test "email has been sent" do
    DailyDigest.new.perform

    refute ActionMailer::Base.deliveries.empty?
  end

end
