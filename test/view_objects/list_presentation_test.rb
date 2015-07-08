require 'test_helper'

class ListPresentationTest < ActionController::TestCase
  fixtures :lists

  test "should return invitation message" do
    lists = ListsPresentation.new nil
    assert_equal 'no_lists', lists.all
  end

  test "should return list of todos" do
    lists = ListsPresentation.new lists(:first)
    assert_equal 'lists', lists.all
  end
end
