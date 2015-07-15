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

  test "should change position of item on item moving" do
    first_item = items(:first)
    new_item_position = items(:fourth).position

    xhr :put, :move, {id: first_item.id, position: new_item_position}

    first_item.reload
    assert_equal new_item_position, first_item.position
  end

  test "should add last position to new item" do
    item = items(:first)

    xhr :post, :create, item: {text: item.text, list_id: item.list_id}
    new_item = assigns(:item)

    assert_response :success
    assert_equal new_item.list.items.size, new_item.position
  end

  test "should change position of item on item checking" do
    first_item = items(:first)

    xhr :put, :update, id: first_item.id

    first_item.reload
    assert_equal first_item.list.items.size, first_item.position
  end

  test "should change position of item on item unchecking" do
    second_item = items(:second)

    xhr :put, :update, id: second_item.id

    second_item.reload
    assert_equal second_item.list.items.size, second_item.position
  end
end
