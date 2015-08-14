require 'test_helper'

class PagerAttributesTest < ActionMailer::TestCase

  def setup
    PagerAttributes.any_instance.stubs(:per_page).returns(3)
  end

  test "should return current page number" do
    pager_attributes = PagerAttributes.new 2
    assert_equal 1, pager_attributes.on_page
  end

  test "should return next page number" do
    pager_attributes = PagerAttributes.new 6
    assert_equal 3, pager_attributes.on_page
  end

end
