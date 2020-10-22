class Customer < ApplicationRecord
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :phone,  presence: true
    validates :phone, numericality: { only_integer: true }
    validates :phone, length: { is: 10}
    #validates_length_of :number, is: 10,  message: "Number must be 10 digit long" 
    validates :email, presence: true
    validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
    has_many :orders     
    def full_name
      "#{first_name} #{last_name}"
    end       
  end
  
  #only integer
  #/\A[+-]?\d+\z/
  
  # validates_format_of :phone, :with => /\d[0-9]\)*\z/ , 
  # :message => "Only positive number without spaces are allowed" 
  
  # validates :phone, :presence => {:message => 'hello world, bad operation!'}, 
  #     :numericality => true, 
  #     :length => { :minimum => 10, :maximum => 15 } 
  
