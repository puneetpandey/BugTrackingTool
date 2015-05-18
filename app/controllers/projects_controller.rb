class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)

    respond_to do | format |
      if @project.save
        flash["success"] = "Project created successfully"
        redirect_to
      else
        flash["error"] = "Unable to create Project at this moment"
        render action: :new
      end
    end
  end

  def show
    @project = Project.find(params[:id])
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])

    respond_to do | format |
      if @project.update_attributes(project_params)
        flash["success"] = "Project updated successfully"
        redirect_to ##
      else
        flash["error"] = "Unable to update Project at this moment"
        render action: :edit
      end
    end
  end

private
  def project_params
    params.require(:project).permit()
  end
end
