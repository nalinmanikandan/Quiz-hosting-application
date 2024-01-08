class Hotel < ApplicationRecord
	
	# ================= Association =================
	has_many :items, dependent: :destroy
	belongs_to :user

	# ================= Validation =================
	validates :name, presence: true
end
