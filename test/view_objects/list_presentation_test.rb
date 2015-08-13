require 'test_helper'

class ListPresentationTest < ActionController::TestCase
  fixtures :lists

  def setup
    @user = users(:first)
  end

  test "should return invitation message" do
    lists = ListsPresentation.new users(:third), lists(:first)
    assert_equal 'no_lists', lists.partial
  end

  test "should return no matches message" do
    lists = ListsPresentation.new user, []
    assert_equal 'no_matches', lists.partial
  end

  test "should return list of todos" do
    lists = ListsPresentation.new user, lists(:first)
    assert_equal 'lists', lists.partial
  end

  private

  attr_reader :user
end
