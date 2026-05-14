class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :uploaded_photos, class_name: "Photo", foreign_key: :uploader_id, dependent: :nullify, inverse_of: :uploader

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  def display_name
    email_address.split("@").first.capitalize
  end
end
