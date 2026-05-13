require "test_helper"

class PhotoTest < ActiveSupport::TestCase
  test "is invalid without a photographer" do
    photo = Photo.new(photographer: nil)
    assert_not photo.valid?
  end
end
