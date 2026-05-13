require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to sign in" do
    post photo_like_path(photos(:one))
    assert_redirected_to new_session_path
  end
end
