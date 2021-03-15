class Service < ApplicationRecord
    validates :name, presence: true
    validates :name, uniqueness: { case_sensitive: false }
    validates :description, presence: true
    validates :kind, presence: true
    validates :phone_number,  presence: true
    validates :phone_number, numericality: { only_integer: true }
    validates :phone_number, length: { is: 10}
    URL_REGEXP = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?\Z/ix
    validates :url, format: { with: URL_REGEXP, message: 'You provided an invalid URL.' }, allow_blank: true
    has_one_attached :picture
    has_many :orders, dependent: :delete_all
    has_many :customers, through: :orders
    geocoded_by :address
    after_validation :geocode, if: ->(obj) { obj.address.present? && obj.street_changed? }

   def address
    sub_address = [street, city, state].compact.join(', ')
    [sub_address, zip].compact.join(' ')
   end
      
   def address_parsed
    self.to_json
   end
end
