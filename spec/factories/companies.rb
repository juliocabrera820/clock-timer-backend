FactoryBot.define do
  factory :company, class: Company do
    name { 'bus' }
    address { 'st 34 #345' }
  end
  factory :random_company, class: Company do
    name { Faker::Company.name }
    address { Faker::Address.full_address }
  end
end
