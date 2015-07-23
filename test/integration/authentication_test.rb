require 'test_helper'

class AuthenticationTest < ActionDispatch::IntegrationTest

  def setup
    @user = FactoryGirl.create(:valid_user)
    post new_user_session_path, user: {email: user.email, password: user.password}
  end

  test "redirect to root path after login" do
    assert_redirected_to root_path
  end

  test "redirect to login page after logout" do
    get destroy_user_session_path

    assert_redirected_to new_user_session_path
  end

  private

  attr_reader :user
end