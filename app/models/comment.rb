class Comment < ApplicationRecord
  belongs_to :item

  has_many :user_comment_votes, dependent: :destroy
  has_many :users , through: :user_comment_votes
  # ================= Validation =================
  validates :message, presence: true
end
