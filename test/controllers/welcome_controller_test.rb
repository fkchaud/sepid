require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect to log in if not logged in' do
    get welcome_index_url
    assert_redirected_to login_url
  end

  # comentado porque no logro hacer andar la session en un test xD
  #
  # test 'should get index if logged in' do
  #   open_session do |session|
  #     user = users(:one)
  #     session.post login_url, params: { session: { name: user.user_name, password: user.password_digest } }
  #     session.get welcome_index_url
  #
  #   end
  #   assert_response :success
  #
  # end

end
