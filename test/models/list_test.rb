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
    assert_includes list.items, items(:first)
    assert_includes list.items, items(:second)
  end

  test "list items ordered by created_at column" do
    list = FactoryGirl.build(:with_items)
    assert_equal [items(:second), items(:first)], list.items
  end
end
