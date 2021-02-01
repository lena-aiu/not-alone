class Assignment < ApplicationRecord
  validates_presence_of :user
  validates_presence_of :customer
  validates :status, presence: true
  belongs_to :customer
  belongs_to :user
end
