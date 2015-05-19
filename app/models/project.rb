class Project < ActiveRecord::Base
  validates :name, presence: true

  has_many :project_memberships
  has_many :users, through: :project_memberships

  belongs_to :location

  accepts_nested_attributes_for :project_memberships, allow_destroy: true
  accepts_nested_attributes_for :users, allow_destroy: true
end
