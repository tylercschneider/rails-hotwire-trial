require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  test "redirects guests to sign in" do
    post photo_like_path(photos(:one))
    assert_redirected_to new_session_path
  end

  test "create persists a like for the signed-in user" do
    sign_in_as(users(:one))
    photo = photos(:two)
    assert_difference -> { photo.likes.count }, 1 do
      post photo_like_path(photo)
    end
  end

  test "create is idempotent when the user has already liked the photo" do
    like = likes(:one)
    sign_in_as(like.user)
    assert_no_difference -> { like.photo.likes.count } do
      post photo_like_path(like.photo)
    end
  end
end
