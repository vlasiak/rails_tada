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

  test "should mark item as done" do
    item = items(:first)
    assert_not item.done

    put :update, id: item.id

    item.reload
    assert item.done
  end

  test "should change position of item on moving" do
    first_item = items(:first)
    new_item_position = items(:fourth).position

    xhr :put, :move, {id: first_item.id, position: new_item_position}

    first_item.reload
    assert_equal new_item_position, first_item.position
  end

  test "should move newly created item to the bottom" do
    item = items(:first)

    xhr :post, :create, item: {text: item.text, list_id: item.list_id}
    new_item = assigns(:item)

    assert_response :success
    assert_equal new_item.list.incompleted_items.count, new_item.position
  end
end
