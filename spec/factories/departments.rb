FactoryBot.define do
  factory :department, class: 'Department' do
    name { 'tech' }
  end

  factory :random_department, class: 'Department' do
    name { Faker::Commerce.department }
  end
end
