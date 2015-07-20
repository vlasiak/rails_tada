require 'test_helper'

class ToDoListsControllerTest < ActionController::TestCase
  fixtures :lists

  def setup
    @user = FactoryGirl.create(:valid_user)
    sign_in @user
  end

  test "blocks unauthenticated access" do
    sign_out @user
    get :index

    assert_redirected_to new_user_session_path
  end

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
