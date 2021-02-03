FactoryBot.define do
  factory :order do
    # product_name { "MyString" }
    # product_count { 1 }
    # #customer { nil }
    # customer_id {FactoryBot.create(:customer).id}
    association :customer
    association :service
    description {"MyString"}
  end
end
