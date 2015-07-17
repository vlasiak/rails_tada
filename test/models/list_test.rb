require 'test_helper'

class ListTest < ActiveSupport::TestCase
  fixtures :lists
  fixtures :items

  def setup
    @list_with_items = FactoryGirl.build(:with_items)
  end

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

  test "lists are ordered by created_at column" do
    lists = List.including_items
    assert_equal [lists(:second), lists(:first)], lists
  end

  test "list has items" do
    assert list_with_items.has_items?
  end

  test "list contains it's items" do
    assert_includes list_with_items.items, items(:first)
    assert_includes list_with_items.items, items(:second)
  end

  test "list's incompleted items are sorted by position column" do
    assert_equal [items(:fourth), items(:first)],
      lists(:first).incompleted_items
  end

  test "list's completed items are sorted by updated_at column" do
    assert_equal [items(:third), items(:second)],
      lists(:first).completed_items
  end

  test "list items are destroyed when destroy list" do
    list_with_items.destroy

    assert_equal [], list_with_items.items
  end

  private

  attr_reader :list_with_items
end
