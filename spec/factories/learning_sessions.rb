FactoryBot.define do
  factory :learning_session do
    user
    passage
    status { :in_progress }
    current_bloom_stage { 1 }
  end
end
