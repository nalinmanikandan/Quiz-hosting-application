class Item < ApplicationRecord
	
	# ================= Association =================
	belongs_to :hotel
	has_many :comments

	has_many :item_tags, dependent: :destroy
	has_many :tags, :through=> :item_tags
	has_many :ratings
	has_and_belongs_to_many :users, join_table: :items_users_read_status
	has_one_attached :image
	belongs_to :user

	accepts_nested_attributes_for :tags, reject_if: ->(tag) { tag['hashtag'].blank? }, allow_destroy: true
	# ================= Validation =================
	validates :name, format: { with: /\A[a-zA-Z0-9]+\z/, message: "Name Cannot Blank and No Special Characters are allowed, Only Letters and Numbers" }
	validates :description, presence: {message: 'Description Cannot be Blank '}
	validates :name, presence: true
end
