class Assignment < ApplicationRecord
  validates_presence_of :user
  validates_presence_of :customer
  belongs_to :customer, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
