require 'test_helper'

class ListTest < ActiveSupport::TestCase
  fixtures :lists

  test "create list with empty title" do
    list = List.new
    assert list.invalid?
    assert list.errors[:title].any?
    assert !list.save
    assert_equal "can't be blank", list.errors[:title].join('; ')
  end

  test "create list with the same title" do
    # using existing title in the fixtures
    list = List.new(title: 'Explore Basecamp! — To-do list basics')
    assert list.invalid?
    assert list.errors[:title].any?
    assert_equal "has already been taken", list.errors[:title].join('; ')
  end
end
