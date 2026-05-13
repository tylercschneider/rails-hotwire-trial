require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to sign in" do
    get root_path
    assert_redirected_to new_session_path
  end
end
