class Service < ApplicationRecord
    has_one_attached :picture
    has_many :orders
    has_many :customers, through: :orders    
end
