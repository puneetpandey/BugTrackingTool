class Project < ActiveRecord::Base
  validates :name, presence: true

  has_many :project_memberships
  has_many :users, through: :project_memberships

  belongs_to :location
end
