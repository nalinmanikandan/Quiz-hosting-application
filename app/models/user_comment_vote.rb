class UserCommentVote < ApplicationRecord
  # == Associations
  belongs_to :user
  belongs_to :comment
  # == Validations
  validates :comment_id, uniqueness: { scope: [:user], message: "Already Voted" }
end
