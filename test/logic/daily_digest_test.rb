require 'test_helper'

class DailyDigestTest < ActionMailer::TestCase

  test "email has been sent" do
    digest = DailyDigest.new
    digest.send

    refute ActionMailer::Base.deliveries.empty?
  end

end
