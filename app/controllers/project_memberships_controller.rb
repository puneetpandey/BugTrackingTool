class ProjectMembershipsController < ApplicationController
  before_filter :get_project

  def new
    @project_membership = @project.project_memberships.new
  end

  def create
    
  end

private
  def get_project
    @project = Project.find(params[:project_id])
  end
end
