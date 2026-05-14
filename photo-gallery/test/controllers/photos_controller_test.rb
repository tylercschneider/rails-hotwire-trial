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

  test "create persists a new photo for signed-in users" do
    sign_in_as(users(:one))
    assert_difference -> { Photo.count }, 1 do
      post photos_path, params: { photo: {
        photographer: "Tyler",
        source_url: "https://example.com",
        src_medium: "https://example.com/img.jpg",
        alt: "Test photo"
      } }
    end
  end

  test "create sets the uploader to the current user" do
    sign_in_as(users(:one))
    post photos_path, params: { photo: {
      photographer: "Tyler",
      source_url: "https://example.com/2",
      src_medium: "https://example.com/img.jpg",
      alt: "Test photo"
    } }
    assert_equal users(:one), Photo.last.uploader
  end

  test "destroy by uploader removes the photo" do
    photo = photos(:one)
    sign_in_as(photo.uploader)
    assert_difference -> { Photo.count }, -1 do
      delete photo_path(photo)
    end
  end

  test "destroy by non-uploader does not remove the photo" do
    sign_in_as(users(:two))
    assert_no_difference -> { Photo.count } do
      delete photo_path(photos(:one))
    end
  end
end
