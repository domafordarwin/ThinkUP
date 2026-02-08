FactoryBot.define do
  factory :system_setting do
    key { Faker::Lorem.unique.word }
    value { Faker::Lorem.word }
  end
end
