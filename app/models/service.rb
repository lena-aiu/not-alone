class Service < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    validates :kind, presence: true
    validates :phone_number,  presence: true
    validates :phone_number, numericality: { only_integer: true }
    validates :phone_number, length: { is: 10}
    has_one_attached :picture
    has_many :orders
    has_many :customers, through: :orders    
end
