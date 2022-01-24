FactoryBot.define do
  factory :random_absence, class: Absence do
    user factory: :random_user
  end
end
