FactoryBot.define do
  factory :user, class: User do
    name { 'jules' }
    email { 'jules@gmail.com' }
    department factory: :department
  end
  factory :random_user, class: User do
    name { Faker::Name.female_first_name }
    email { Faker::Internet.email(domain: 'example') }
    department factory: :random_department
  end
end
