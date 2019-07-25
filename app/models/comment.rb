class Comment < ApplicationRecord
  belongs_to :washer
  has_many_attached :images
  validates :washer_id, uniqueness: { scope: :ip_address }
  scope :approved, -> { where(approved: true) }
end
