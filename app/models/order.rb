class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :service
  validates :description, presence: true
  #accepts_nested_attributes_for :customer
end
