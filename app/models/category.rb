class Category < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  has_many :orders 
end
