class Assignment < ApplicationRecord
  belongs_to :customer, dependent: :destroy
  belongs_to :user, dependent: :destroy
end
