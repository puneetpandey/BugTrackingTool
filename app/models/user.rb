require 'role_model'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :first_name, :last_name, :username, :email, presence: true

  include RoleModel

  roles_attribute :roles_mask

  roles :admin, :manager, :lead

  has_one :user_profile, dependent: :destroy
  has_many :project_memberships
  has_many :projects, through: :project_memberships

  has_many :responses, dependent: :destroy
  has_many :awaiting_responses, -> { where(status: Response::STATUS[:completed]) },
    class: "Response", foreign_key: :approver

  def full_name
    first_name + " " + last_name
  end

  def get_role_name
    if self.has_role? :admin
      "Admin"
    elsif self.has_role? :manager
      "Manager"
    elsif self.has_role? :lead
      "Team Lead"
    else
      "Guest"
    end
  end
end
