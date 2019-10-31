require 'test_helper'

class PasswordResetControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get password_reset_index_url
    assert_response :success
  end

  test "should get reset" do
    get password_reset_reset_url
    assert_response :success
  end

end
