class Like < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :photo, counter_cache: true, touch: true

  validates :user_id, uniqueness: { scope: :photo_id }
end
