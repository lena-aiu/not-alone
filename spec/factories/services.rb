require 'faker'

FactoryBot.define do
  factory :service do
    name { Faker::Lorem.unique.word }
    description {"MyDesc"}
    kind {"any"}
    f.phone { Faker::Number.number(digits: 10) }
    #url {"www.example.org"}
    #picture {"uno.jpeg"}
    f.street { Faker::Address.street_address }
    f.city { Faker::Address.city }
    f.state { Faker::Address.state }
    f.zip { Faker::Number.number(digits: 5) }
    # t.float "latitude"
    # t.float "longitude"
    f.latitude { Faker::Address.latitude } #=> "-58.17256227443719"
    f.longitude { Faker::Address.longitude } #=> "-156.65548382095133"

  end
end
