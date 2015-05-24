class UserProfile < ActiveRecord::Base
  validates :user, :employee_id, :manager_employee_id, presence: true

  has_many :subordinates, class_name: "UserProfile", foreign_key: :manager_employee_id
  belongs_to :manager, class_name: "UserProfile", foreign_key: :manager_employee_id

  belongs_to :user
  belongs_to :location
end
