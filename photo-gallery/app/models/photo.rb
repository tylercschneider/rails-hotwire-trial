class Photo < ApplicationRecord
  validates :photographer, presence: true
end
