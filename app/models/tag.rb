class Tag < ApplicationRecord
  validates :hashtag, presence: true

  has_many :item_tags, dependent: :destroy
  has_many :items, :through=> :item_tags
  # ================= Validation =================
  validates :hashtag, presence: true
end
