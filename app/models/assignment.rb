class Assignment < ApplicationRecord
  validates_presence_of :user
  validates_presence_of :customer
  validates :status, presence: true
  belongs_to :customer, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
