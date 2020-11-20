FactoryBot.define do
  factory :service do
    name { "MyString" }
    description {"MyDesc"}
    kind {"any"}
    phone_number {1234567890}
    #url {"www.example.org"}
    #picture {"uno.jpeg"}

  end
end
  # factory :service do |f|
  #   f.name { Faker::Name.name }
  #   f.description { Faker::Description.description("dsc") }
  #   f.kind { Faker::Kind.kind }
  #   f.phone_number { Faker::Number.phone_number(digits: 10) }
  # end

