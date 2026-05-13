require "test_helper"

class SeedTest < ActiveSupport::TestCase
  test "loads 10 photos from photos.csv" do
    Photo.delete_all
    load Rails.root.join("db/seeds.rb").to_s
    assert_equal 10, Photo.count
  end

  test "creates the admin user" do
    User.delete_all
    load Rails.root.join("db/seeds.rb").to_s
    assert User.find_by(email_address: "admin@example.com")
  end
end
