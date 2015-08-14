require 'test_helper'

class ListPresentationTest < ActionController::TestCase
  fixtures :lists

  test "should return invitation message" do
    List.expects(:count).returns(0)
    lists = ListsPresentation.new lists(:first)
    assert_equal 'no_lists', lists.partial
  end

  test "should return no matches message" do
    lists = ListsPresentation.new []
    assert_equal 'no_matches', lists.partial
  end

  test "should return list of todos" do
    lists = ListsPresentation.new lists(:first)
    assert_equal 'lists', lists.partial
  end

end
