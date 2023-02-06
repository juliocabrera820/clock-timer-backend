FactoryBot.define do
  factory :absence, class: Absence do
    user factory: :user
  end
end
