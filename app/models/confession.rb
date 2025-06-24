class Confession < ApplicationRecord

	has_many :reactions, dependent: :destroy

	validates :body, presence: true, length: { maximum: 500 }
end
