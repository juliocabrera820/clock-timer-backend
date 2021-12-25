FactoryBot.define do
  factory :user, class: User do
    name { 'jules' }
    email { 'jules@gmail.com' }
    company factory: :company
  end
end
