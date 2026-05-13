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
end
