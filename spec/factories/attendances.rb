FactoryBot.define do
  factory :attendance, class: 'Attendance' do
    user factory: :user
  end
end
