class Photo < ApplicationRecord
  has_many :likes, dependent: :destroy

  validates :photographer, presence: true
  validates :source_url, presence: true
  validates :src_medium, presence: true

  def liked_by?(user)
    likes.exists?(user: user)
  end
end
