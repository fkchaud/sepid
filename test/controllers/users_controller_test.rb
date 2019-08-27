require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "verificar mail de usuario" do
    assert_equal "pablobaldini1994@gmail.com", users(:one).email
  end
 
  end

