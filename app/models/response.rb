class Response < ActiveRecord::Base
  attr_accessor :month_year

  STATUS = { pending: 1, completed: 2, approved: 3, referred_back: 4 }
  PREVIOUS_MONTH = Date.today.prev_month.month
  YEAR = Date.today.prev_month.month == 12 ? Date.today.year - 1 : Date.today.year

  ## Validations
  validates :project_id, :month, :year, :reference_key, presence: true
  validates :is_bug_exist, :inclusion => { :in => [true, false], message: ": New Bug to report has not been selected" }
  validates :bug_path, :time_when_bug_occured, :bug_summary, :bug_description, :primary_reason,
    :secondary_reason, :affected_stakeholders, :bug_created_by, :shift_timings, :tenure_of_employee_in_company, :technology_area, :employee_current_role,
    :bug_captured_by, :comments, :impact_of_bug, presence: true, if: :bug_exist?
  validates :bug_created_by, :bug_captured_by, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "Email format is incorrect" }, if: :bug_exist?

  before_validation :generate_other_imp_data
  after_validation :perform_bug_related_checks, on: [ :create, :update ]
  after_create :populate_pending_with

  belongs_to :project
  belongs_to :user
  belongs_to :awaiting_response, class: "User", foreign_key: :approval_owner
  belongs_to :approved_and_referred_back_response, class: "User", foreign_key: :approval_owner

  def month_and_year
    Date::MONTHNAMES[self.month].to_s + "-" + self.year.to_s
  end

  def get_status
    case
    when self.status == STATUS[:pending]
      "Pending" # STATUS.key(0).capitalize
    when self.status == STATUS[:completed]
      "Waiting for Approval" # STATUS.key(1).capitalize
    when self.status == STATUS[:approved]
      "Approved" # STATUS.key(2).capitalize
    when self.status == STATUS[:referred_back]
      "Referred Back" # STATUS.key(3).capitalize
    end
  end

protected
  def bug_exist?
    is_bug_exist
  end

  def generate_other_imp_data
    return unless month_year
    self.month, self.year, self.status = Date::MONTHNAMES.index(month_year.split("-").first).to_i, month_year.split("-").last, STATUS[:completed]
    self.reference_key = Time.now.to_i if self.new_record?
  end

  def perform_bug_related_checks
    errors.add(:base, "You are not allowed to report non-occurence in advance.") if month.to_i == Time.now.month.to_i && !is_bug_exist
  end

  def populate_pending_with
    self.update_columns(approval_owner: self.user.user_profile.manager.user.id)
  end
end
