class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :assignments
  has_many :customers, through: :assignments       
         :recoverable, :rememberable, :validatable, password_length: 6..128
  validate :password_complexity
  
  def password_complexity
    if password.present? and not password.match(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,25}$/)
      errors.add :password, "must be at least 6 characters long and include 1 uppercase, 1 number, and 1 special character."
    end
  end
end
