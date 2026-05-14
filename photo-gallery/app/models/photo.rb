class Photo < ApplicationRecord
  belongs_to :uploader, class_name: "User", optional: true
  has_many :likes, dependent: :destroy

  validates :photographer, presence: true
  validates :source_url, presence: true
  validates :src_medium, presence: true

  def liked_by?(user)
    likes.exists?(user: user)
  end
end
