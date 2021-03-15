require 'faker'

FactoryBot.define do
  factory :assignment do
    association :customer
    association :user
    status { "MyString" }
  end
end
