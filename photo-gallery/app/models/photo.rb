class Photo < ApplicationRecord
  validates :photographer, presence: true
  validates :source_url, presence: true
  validates :src_medium, presence: true
end
