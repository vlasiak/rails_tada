require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users
  fixtures :lists

  test "validate email presence" do
    user = FactoryGirl.build(:without_email)

    assert user.invalid?
    assert_equal ["can't be blank"], user.errors[:email]
  end

  test "validate email uniqueness" do
    user = users(:first)
    new_user = User.new(email: user.email)

    assert new_user.invalid?
    assert_equal ["has already been taken"], new_user.errors[:email]
  end

  test "validate password min length" do
    user = User.new(password: '1234')

    assert user.invalid?
    assert_equal ["is too short (minimum is 8 characters)"], user.errors[:password]
  end

  test "user has lists" do
    user = FactoryGirl.build(:valid_user)
    assert_equal [lists(:first), lists(:second)], user.lists
  end
end
