FactoryBot.define do
  factory :announcement do
    title { "시스템 공지사항" }
    content { "ThinkUp 서비스가 업데이트되었습니다." }
    published_at { 1.day.ago }
    association :user, factory: [:user, :diagnosis_admin]
  end
end
