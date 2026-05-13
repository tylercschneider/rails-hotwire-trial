require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to sign in" do
    get photos_path
    assert_redirected_to new_session_path
  end
end
