require 'test_helper'

class ToDoItemsControllerTest < ActionController::TestCase
  test "should create list_item via ajax" do
    item = items(:first)

    assert_difference('Item.count') do
      xhr :post, :create, id: item.list_id, item: {text: item.text}
    end

    assert_response :success
  end
end
