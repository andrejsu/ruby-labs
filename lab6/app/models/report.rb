class Report < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { maximum: 500 }
end
