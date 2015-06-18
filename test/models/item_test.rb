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
end
