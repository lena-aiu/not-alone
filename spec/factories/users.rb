require 'faker'

FactoryBot.define do
  factory :user do |f|
      f.email { Faker::Internet.email }
      f.password {'Pa$$word20'}
  end
end
