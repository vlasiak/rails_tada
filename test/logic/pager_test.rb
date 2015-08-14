require 'test_helper'

class PagerTest < ActionMailer::TestCase

  def setup
    @pager = Pager.new
    Pager.any_instance.stubs(:per_page).returns(3)
  end

  test "should return current page number" do
    List.expects(:count).returns(1)
    assert_equal ({per_page: 3, on_page: 1}), pager.info
  end

  test "should return next page number" do
    List.expects(:count).returns(6)
    assert_equal ({per_page: 3, on_page: 3}), pager.info
  end

  private

  attr_reader :pager

end
