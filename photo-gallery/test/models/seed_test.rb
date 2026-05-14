require "test_helper"

class SeedTest < ActiveSupport::TestCase
  test "loads 13 photos from photos.csv" do
    Photo.destroy_all
    load Rails.root.join("db/seeds.rb").to_s
    assert_equal 13, Photo.count
  end

  test "creates the admin user" do
    User.destroy_all
    load Rails.root.join("db/seeds.rb").to_s
    assert User.find_by(email_address: "admin@example.com")
  end

  test "creates alice as a viewer user" do
    User.destroy_all
    load Rails.root.join("db/seeds.rb").to_s
    assert User.find_by(email_address: "alice@example.com")
  end

  test "creates 9 sample likes" do
    Like.destroy_all
    load Rails.root.join("db/seeds.rb").to_s
    assert_equal 9, Like.count
  end
end
