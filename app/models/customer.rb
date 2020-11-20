class Customer < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone,  presence: true
    validates :phone, numericality: { only_integer: true }
    validates :phone, length: { is: 10}
    #validates_length_of :number, is: 10,  message: "Number must be 10 digit long" 
    validates :email, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    has_many :orders, dependent: :delete_all
    has_many :services, through: :orders  
    #accepts_nested_attributes_for :orders    
    def full_name
      "#{first_name} #{last_name}"
    end       
  end
  
 
  
