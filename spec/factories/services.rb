require 'faker'

FactoryBot.define do
  factory :service do
    name { Faker::Lorem.unique.word }
    description {"MyDesc"}
    kind {"any"}
    phone_number {1234567890}
    #url {"www.example.org"}
    #picture {"uno.jpeg"}
  end
end
