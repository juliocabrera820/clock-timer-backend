FactoryBot.define do
  factory :user, class: User do
    name { 'jules' }
    email { 'jules@gmail.com' }
    company factory: :company
  end
  factory :random_user, class: User do
    name { Faker::Name.female_first_name }
    email { Faker::Internet.email(domain: 'example') }
    company factory: :random_company
  end
end
