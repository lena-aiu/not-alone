class Assignment < ApplicationRecord
  validates_presence_of :user
  validates_presence_of :customer
  belongs_to :customer
  belongs_to :user
  validates_uniqueness_of :user_id, :scope => :customer_id
end
