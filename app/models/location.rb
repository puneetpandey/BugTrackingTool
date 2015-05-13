class Location < ActiveRecord::Base
  validates :name, presence: true

  has_many :user_profiles
  has_many :projects
end
