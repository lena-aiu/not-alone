require 'faker'

FactoryBot.define do
  factory :customer do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.phone { Faker::Number.number(digits: 10) }
    f.email { Faker::Internet.email }
    f.street { Faker::Address.street_address }
    f.city { Faker::Address.city }
    f.state { Faker::Address.state }
    f.zip { Faker::Number.number(digits: 5) }
  end
end
