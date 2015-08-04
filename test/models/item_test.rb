require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  fixtures :lists
  fixtures :items

  test "item cannot be saved without text" do
    item = FactoryGirl.build(:without_text)
    assert item.invalid?
    assert !item.save
    assert_equal ["can't be blank"], item.errors[:text]
  end

  test "item cannot be saved without list_id reference" do
    item = FactoryGirl.build(:without_list_reference)
    assert item.invalid?
    assert !item.save
    assert_equal ["can't be blank"], item.errors[:list_id]
  end

  test "item belongs to list" do
    item = items(:second)
    assert_equal lists(:first), item.list
  end

  test "should return incompleted items" do
    assert_equal [items(:first), items(:fourth)],
      lists(:first).items.incompleted
  end

  test "should return completed items" do
    assert_equal [items(:second), items(:third)],
      lists(:first).items.completed
  end

  test "should return completed items for today" do
    item = FactoryGirl.create(:completed_today)

    assert_equal [item], Item.completed_today
  end

  test "should return items including their lists" do
    item = Item.with_list.first

    counter = count_sql_queries_to_load do
      item.list
    end

    assert_equal 0, counter
  end

  test "items are ordered by list and completed_at" do
    items = Item.completed.with_list.ordered

    assert_equal [items(:third), items(:second)], items
  end

  test "should unset item position on checking" do
    first_item = items(:first)
    first_item.mark

    first_item.reload
    assert_nil first_item.position
  end

  test "should set completed_at on checking" do
    item = items(:first)
    assert_nil item.completed_at
    item.mark

    item.reload
    assert_equal item.updated_at.to_i, item.completed_at.to_i
  end

  test "should move item to the bottom on unchecking" do
    second_item = items(:second)
    second_item.mark

    second_item.reload
    assert_equal second_item.list.items.incompleted.count, second_item.position
  end

  test "should unset completed_at on unchecking" do
    item = items(:second)
    assert item.completed_at
    item.mark

    item.reload
    assert_nil item.completed_at
  end

  test "should move newly created item to the bottom" do
    item = FactoryGirl.create(:with_valid_attributes)
    assert_equal item.list.items.incompleted.count, item.position
  end
end