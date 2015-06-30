require 'test_helper'

class ToDoItemsControllerTest < ActionController::TestCase
  fixtures :items

  test "should instantiate a new item in the list" do
    get :new, id: items(:first).id
    item = FactoryGirl.build(:only_with_list_reference)

    assert_response :success
    assert item.attributes == assigns(:item).attributes
  end

  test "should create a new item in the list" do
    item = items(:first)

    assert_difference('Item.count') do
      xhr :post, :create, item: {text: item.text, list_id: item.list_id}
    end

    assert_response :success
  end
end
