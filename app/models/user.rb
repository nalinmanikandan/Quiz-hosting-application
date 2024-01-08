class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ================= Association =================
  has_and_belongs_to_many :items, join_table: :items_users_read_status
  has_many :hotels
  has_many :items
  has_many :user_comment_votes, :dependent => :destroy
  has_many :comment , through: :user_comment_votes
end
