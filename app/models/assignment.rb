class Assignment < ApplicationRecord
  validates_presence_of :user
  validates_presence_of :customer
  belongs_to :customer
  belongs_to :user
end
