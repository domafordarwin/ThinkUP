class ActivityReport < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :school, optional: true
  belongs_to :generated_by, class_name: "User"

  enum :report_type, { student_report: 0, school_report: 1, overall_report: 2 }

  validates :report_type, presence: true
  validates :period_start, presence: true
  validates :period_end, presence: true
end
