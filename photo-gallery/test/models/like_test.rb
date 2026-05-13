require "test_helper"

class LikeTest < ActiveSupport::TestCase
  test "is invalid when the user has already liked the photo" do
    existing = likes(:one)
    duplicate = Like.new(user: existing.user, photo: existing.photo)
    assert_not duplicate.valid?
  end
end
