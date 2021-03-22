require 'faker'

FactoryBot.define do
  factory :service do |f|
    name { Faker::Lorem.unique.word }
    description {"MyDesc"}
    kind {"any"}
    f.phone_number { Faker::Number.number(digits: 10) }
    #url {"www.example.org"}
    #picture {"uno.jpeg"}
    f.street { Faker::Address.street_address }
    f.city { Faker::Address.city }
    f.state { Faker::Address.state }
    f.zip { Faker::Number.number(digits: 5) }
  end
end
