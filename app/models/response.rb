class Response < ActiveRecord::Base
  attr_accessor :month_year

  STATUS = { pending: 1, completed: 2, approved: 3, referred_back: 4 }
  PREVIOUS_MONTH = Date.today.prev_month.month
  YEAR = Date.today.prev_month.month == 12 ? Date.today.year - 1 : Date.today.year

  ## Validations
  validates :project_id, :month, :year, :transcation_id, presence: true
  validates :is_bug_exist, :inclusion => { :in => [true, false], message: ": New Bug to report has not been selected" }
  validates :bug_path, :time_when_bug_occured, :bug_summary, :bug_description, :primary_reason,
    :secondary_reason, :affected_stakeholders, :bug_created_by, :shift_timings, :tenure_of_employee_in_company, :technology_area, :employee_current_role,
    :bug_captured_by, :comments, :impact_of_bug, presence: true, if: :is_bug_exist?

  validates :bug_created_by, :bug_captured_by, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "Email format is incorrect" }, if: :is_bug_exist?

  belongs_to :project
  belongs_to :user
  #belongs_to :awaiting_response, class: "User"
end
