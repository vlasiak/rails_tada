require 'test_helper'

class FlashNotificationTest < ActionController::TestCase
  test "should return flash alert" do
    flash[:alert] = 'alert message'
    message = FlashNotification.new flash
    assert_equal 'alert message', message.alert
  end

  test "should return nil on empty flash" do
    message = FlashNotification.new flash
    assert_nil message.alert
  end
end
