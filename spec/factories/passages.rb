FactoryBot.define do
  factory :passage do
    title { Faker::Book.title }
    content { Faker::Lorem.paragraphs(number: 3).join("\n\n") }
    genre { :non_fiction }
    difficulty { rand(1..5) }
    min_grade { 3 }
    max_grade { 6 }
    subject_tags { "과학,환경" }
  end
end
