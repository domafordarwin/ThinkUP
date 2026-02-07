FactoryBot.define do
  factory :school do
    name { Faker::Educator.university }
    region { "서울" }
  end
end
