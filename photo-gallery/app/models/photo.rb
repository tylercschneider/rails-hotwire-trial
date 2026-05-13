class Photo < ApplicationRecord
  validates :photographer, presence: true
  validates :source_url, presence: true
end
