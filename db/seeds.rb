puts "Creating users..."
admin = User.find_or_create_by!(email: "admin@thinkup.kr") do |u|
  u.name = "시스템관리자"
  u.password = "password123"
  u.role = :system_admin
end

dev = User.find_or_create_by!(email: "dev@thinkup.kr") do |u|
  u.name = "콘텐츠개발자"
  u.password = "password123"
  u.role = :developer
end

student = User.find_or_create_by!(email: "student@thinkup.kr") do |u|
  u.name = "김학생"
  u.password = "password123"
  u.role = :student
  u.grade_level = 5
  u.thinking_level = 1
end

puts "Creating passages..."
p1 = Passage.find_or_create_by!(title: "지구 온난화와 우리의 미래") do |p|
  p.content = "지구의 평균 기온이 산업혁명 이후 약 1.1도 상승했습니다. 이러한 변화는 작아 보이지만, 지구 전체의 기후 시스템에는 큰 영향을 미칩니다. 북극의 빙하가 녹고, 해수면이 상승하며, 극단적인 날씨가 더 자주 발생하고 있습니다.\n\n과학자들은 이산화탄소와 같은 온실가스가 주된 원인이라고 말합니다. 우리가 자동차를 타고, 공장에서 물건을 만들고, 전기를 사용할 때 온실가스가 배출됩니다. 이 가스들이 지구를 마치 온실처럼 감싸서 열이 빠져나가지 못하게 합니다.\n\n하지만 희망은 있습니다. 재생에너지 기술이 빠르게 발전하고 있고, 전 세계 많은 나라가 탄소 배출을 줄이기 위한 약속을 하고 있습니다. 가장 중요한 것은 우리 각자가 환경을 생각하는 작은 실천을 시작하는 것입니다."
  p.genre = :non_fiction
  p.difficulty = 2
  p.min_grade = 3
  p.max_grade = 6
  p.subject_tags = "과학,환경,사회"
end

if p1.base_questions.empty?
  p1.base_questions.create!([
    { content: "이 글에서 말하는 지구 온난화의 주된 원인은 무엇인가요?", bloom_level: :remember, position: 0 },
    { content: "온실가스가 지구를 따뜻하게 만드는 원리를 자신의 말로 설명해보세요.", bloom_level: :understand, position: 1 },
    { content: "우리 일상에서 온실가스를 줄일 수 있는 방법을 3가지 이상 생각해보세요.", bloom_level: :apply, position: 2 }
  ])
end

p2 = Passage.find_or_create_by!(title: "윤동주 - 서시") do |p|
  p.content = "죽는 날까지 하늘을 우러러\n한 점 부끄럼이 없기를,\n잎새에 이는 바람에도\n나는 괴로워했다.\n별을 노래하는 마음으로\n모든 죽어 가는 것을 사랑해야지\n그리고 나한테 주어진 길을\n걸어가야겠다.\n\n오늘 밤에도 별이 바람에 스치운다."
  p.genre = :literature
  p.difficulty = 3
  p.min_grade = 5
  p.max_grade = 9
  p.subject_tags = "문학,시,윤동주"
end

if p2.base_questions.empty?
  p2.base_questions.create!([
    { content: "이 시에서 화자가 바라는 것은 무엇인가요?", bloom_level: :remember, position: 0 },
    { content: "'잎새에 이는 바람에도 괴로워했다'는 표현이 의미하는 바를 설명해보세요.", bloom_level: :understand, position: 1 },
    { content: "이 시의 주제를 현재 자신의 생활에 적용한다면 어떤 다짐을 할 수 있을까요?", bloom_level: :apply, position: 2 }
  ])
end

puts "Creating schools..."
school = School.find_or_create_by!(name: "서울 사고력 초등학교") do |s|
  s.region = "서울"
end

puts "Creating school enrollments..."
SchoolEnrollment.find_or_create_by!(school: school, user: student) do |e|
  e.role_in_school = :student_member
end

school_admin_user = User.find_or_create_by!(email: "schooladmin@thinkup.kr") do |u|
  u.name = "학교담당자"
  u.password = "password123"
  u.role = :school_admin
end

SchoolEnrollment.find_or_create_by!(school: school, user: school_admin_user) do |e|
  e.role_in_school = :admin_member
end

parent_user = User.find_or_create_by!(email: "parent@thinkup.kr") do |u|
  u.name = "김학부모"
  u.password = "password123"
  u.role = :parent
end

SchoolEnrollment.find_or_create_by!(school: school, user: parent_user) do |e|
  e.role_in_school = :parent_member
end

ParentStudent.find_or_create_by!(parent: parent_user, student: student)

puts "Creating programs..."
program = Program.find_or_create_by!(name: "2026 1학기 사고력 프로그램") do |p|
  p.description = "블룸의 택소노미 기반 사고력 증진 프로그램"
  p.target_grade_min = 3
  p.target_grade_max = 6
  p.starts_on = Date.new(2026, 3, 1)
  p.ends_on = Date.new(2026, 7, 31)
end

ProgramAssignment.find_or_create_by!(program: program, school: school)

Passage.all.each_with_index do |passage, i|
  ProgramPassage.find_or_create_by!(program: program, passage: passage) do |pp|
    pp.position = i
  end
end

puts "Creating diagnosis admin..."
diagnosis_admin = User.find_or_create_by!(email: "diagnosis@thinkup.kr") do |u|
  u.name = "진단관리자"
  u.password = "password123"
  u.role = :diagnosis_admin
end

puts "Creating announcements..."
Announcement.find_or_create_by!(title: "ThinkUp 서비스 오픈 안내") do |a|
  a.content = "ThinkUp 서비스가 정식 오픈되었습니다. 블룸의 택소노미를 기반으로 한 발문 생성 훈련을 시작해보세요!"
  a.user = diagnosis_admin
  a.published_at = Time.current
end

Announcement.find_or_create_by!(title: "2026년 1학기 프로그램 안내") do |a|
  a.content = "2026년 1학기 사고력 증진 프로그램이 시작됩니다. 학교 담당자는 학생 계정을 생성하고 프로그램에 참여시켜 주세요."
  a.user = diagnosis_admin
  a.published_at = Time.current
end

puts "Seed complete!"
puts "Users: #{User.count}, Schools: #{School.count}, Programs: #{Program.count}"
puts "Enrollments: #{SchoolEnrollment.count}, Parent-Student: #{ParentStudent.count}"
puts "Announcements: #{Announcement.count}"
