require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  test "is invalid without a photographer" do
    photo = Photo.new(photographer: nil)
    assert_not photo.valid?
  end

  test "is invalid without a source_url" do
    photo = Photo.new(photographer: "Felix", source_url: nil)
    assert_not photo.valid?
  end

  test "is invalid without a src_medium" do
    photo = Photo.new(photographer: "Felix", source_url: "https://example.com", src_medium: nil)
    assert_not photo.valid?
  end

  test "liked_by? returns true for the liking user" do
    like = likes(:one)
    assert like.photo.liked_by?(like.user)
  end

  test "likes_count counter cache increments when a like is created" do
    photo = photos(:two)
    assert_difference -> { photo.reload.likes_count }, 1 do
      photo.likes.create!(user: users(:one))
    end
  end
end
