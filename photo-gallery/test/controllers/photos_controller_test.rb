require "test_helper"

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to sign in" do
    get photos_path
    assert_redirected_to new_session_path
  end

  test "lists all photos for signed-in users" do
    sign_in_as(User.take)
    get photos_path
    assert_select "li.photo", count: Photo.count
  end

  test "new redirects guests to sign in" do
    get new_photo_path
    assert_redirected_to new_session_path
  end
end
