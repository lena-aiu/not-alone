FactoryBot.define do
  factory :customer do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.phone { Faker::Number.number(digits: 10) }
    f.email { Faker::Internet.email }
    f.street { Faker::Name.street }
    f.city { Faker::Name.city }
    f.state { Faker::Name.state }
    f.zip { Faker::Number.number(digits: 5) }
    

  end
end
