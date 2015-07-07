require 'test_helper'

class ToDoListsControllerTest < ActionController::TestCase
  fixtures :lists

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lists)
  end

  test "should instantiate a new list" do
    get :new
    list = FactoryGirl.build(:empty_list)

    assert_response :success
    assert list.attributes == assigns(:list).attributes
  end

  test "should create a new list" do
    assert_difference('List.count') do
      xhr :post, :create, list: {title: 'list title', description: 'list description'}
    end

    assert_response :success
    assert_not_nil assigns(:list)
  end
end
