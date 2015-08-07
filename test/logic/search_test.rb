require 'test_helper'

class SearchTest < ActionMailer::TestCase
  fixtures :lists

  test "should return matched lists" do
    search = Search.new 'is:todo author:vasyll@tada.com Read'
    assert_equal [lists(:first)], search.perform
  end

end
