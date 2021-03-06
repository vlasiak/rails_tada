require 'test_helper'

class ToDoListsControllerTest < ActionController::TestCase
  fixtures :lists

  def setup
    @user = FactoryGirl.create(:valid_user)
    sign_in @user
  end

  test "should get index" do
    get :index

    assert_response :success
    assert_not_nil assigns(:lists)
  end

  test "should return lists on a second page" do
    xhr :get, :index, page: 2, cookies: {filter: ''}

    assert_response :success
    assert_equal [lists(:first), lists(:fifth)], assigns(:lists_per_page)
  end

  test "should instantiate a new list" do
    get :new
    list = FactoryGirl.build(:empty_list)

    assert_response :success
    assert list.attributes == assigns(:list).attributes
  end

  test "should create a new list" do
    assert_difference('List.count') do
      xhr :post, :create, list: {title: 'title', description: 'description'}
    end

    assert_response :success
    assert_not_nil assigns(:list)
  end

  test "newly created list belongs to current user" do
    xhr :post, :create, list: {title: 'title', description: 'description'}

    assert_equal @user.email, assigns(:list).created_by
  end
end
