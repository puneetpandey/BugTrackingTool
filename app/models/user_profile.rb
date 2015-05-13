class UserProfile < ActiveRecord::Base
  validates :user, :employee_id, :manager_employee_id, presence: true

  has_one :manager, foreign_key: :manager_employee_id, class: :user_profile
  has_many :subordinates, class: :user_profile

  belongs_to :user
  belongs_to :location
end
