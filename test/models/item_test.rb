require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  test "item cannot be saved without text" do
    item = FactoryGirl.build(:without_text)
    assert item.invalid?
    assert !item.save
    assert_equal "can't be blank", item.errors[:text].join('; ')
  end

  test "item cannot be saved without list_id reference" do
    item = FactoryGirl.build(:without_list_reference)
    assert item.invalid?
    assert !item.save
    assert_equal "can't be blank", item.errors[:list_id].join('; ')
  end

  test "should unset item position on checking" do
    first_item = items(:first)
    first_item.mark

    first_item.reload
    assert_nil first_item.position
  end

  test "should move item to the bottom on unchecking" do
    second_item = items(:second)
    second_item.mark

    second_item.reload
    assert_equal second_item.list.incompleted_items.count, second_item.position
  end

  test "should move newly created item to the bottom" do
    item = FactoryGirl.create(:with_valid_attributes)
    assert_equal item.list.incompleted_items.count, item.position
  end
end
