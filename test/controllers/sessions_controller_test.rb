require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  tests Users::SessionsController

  def setup
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  test "should set flash on new" do
    get :new
    assert_not_nil assigns(:flash)
  end
end
