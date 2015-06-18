require 'test_helper'

class ListTest < ActiveSupport::TestCase
  fixtures :items

  test "validate title presence" do
    list = FactoryGirl.build(:without_title)
    assert list.invalid?
    assert !list.save
    assert_equal "can't be blank", list.errors[:title].join('; ')
  end

  test "validate title uniqueness" do
    list = FactoryGirl.build(:with_same_title)
    assert list.invalid?
    assert !list.save
    assert_equal "has already been taken", list.errors[:title].join('; ')
  end

  test "list has items" do
    list = FactoryGirl.build(:with_items)
    assert_equal [items(:first), items(:second)], list.items
  end
end
