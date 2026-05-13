require "test_helper"

class SeedTest < ActiveSupport::TestCase
  test "loads 10 photos from photos.csv" do
    Photo.delete_all
    load Rails.root.join("db/seeds.rb").to_s
    assert_equal 10, Photo.count
  end
end
