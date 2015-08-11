require 'test_helper'

class FinderTest < ActionMailer::TestCase
  fixtures :lists

  test "should return all lists" do
    Parser.any_instance.stubs(:perform).returns({status: nil, author: nil, phrase: ''})
    search = Finder.new('')

    assert_equal [lists(:second), lists(:first)], search.perform
  end

  test "should return matched lists by all parameters" do
    Parser.any_instance.stubs(:perform).returns({status: false, author: 'vasyll@tada.com', phrase: 'read'})
    search = Finder.new('')

    assert_equal [lists(:first)], search.perform
  end

  test "should return matched lists by author only" do
    Parser.any_instance.stubs(:perform).returns({status: nil, author: 'vasyll@tada.com', phrase: ''})
    search = Finder.new('')

    assert_equal [lists(:second), lists(:first)], search.perform
  end

  test "should return lists containing done items" do
    Parser.any_instance.stubs(:perform).returns({status: true, author: nil, phrase: ''})
    search = Finder.new('')

    assert_equal [lists(:first)], search.perform
  end

  test "should return lists containing phrase" do
    Parser.any_instance.stubs(:perform).returns({status: nil, author: nil, phrase: 'read'})
    search = Finder.new('')

    assert_equal [lists(:first)], search.perform
  end

end
