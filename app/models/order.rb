class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :service
  validates :description, presence: true
  #accepts_nested_attributes_for :customer
  belongs_to :category
  validates_uniqueness_of :category_id, :scope => :service_id
end
