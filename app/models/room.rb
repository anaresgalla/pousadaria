class Room < ApplicationRecord
  validates :name, :description, :area, :max_guests, :standard_overnight, presence: true
  
  belongs_to :lodge
end