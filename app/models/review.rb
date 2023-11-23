class Review < ApplicationRecord
  validates :rating, :comment, presence: true  
  belongs_to :booking
  has_one :user, through: :booking
  has_one :lodge, through: :booking
end