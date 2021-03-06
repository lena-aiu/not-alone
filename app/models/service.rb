class Service < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false }
    validates :description, presence: true
    validates :kind, presence: true
    validates :phone_number,  presence: true
    validates :phone_number, numericality: { only_integer: true }
    validates :phone_number, length: { is: 10}
    URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/ix
    validates :url, format: { with: URL_REGEXP, message: 'You provided invalid URL' }
    has_one_attached :picture
    has_many :orders, dependent: :delete_all
    has_many :customers, through: :orders
end
