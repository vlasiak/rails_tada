require 'test_helper'

class ItemTest < ActiveSupport::TestCase
   test "create item with empty text and list reference" do
    item = Item.new
    assert item.invalid?
    assert item.errors[:text].any?
    assert item.errors[:list_id].any?
    assert !item.save
    assert_equal "can't be blank", item.errors[:text].join('; ')
    assert_equal "can't be blank", item.errors[:list_id].join('; ')
  end
end
