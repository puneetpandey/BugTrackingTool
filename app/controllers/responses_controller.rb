class ResponsesController < ApplicationController
  def index
    @responses = current_user.responses.where( status: Response::STATUS[params[:req_type].to_sym] )
  end

  def new
    @response = current_user.responses.new
  end

  def create
    @response = current_user.responses.new response_params

    respond_to do | format |
      if @response.save
        flash[:notice] = "Response is saved successfully"
        format.html { redirect_to root_url }
      else
        flash[:error] = "Unable to save Response. Please check the errors"
        format.html { render action: :new }
      end
    end
  end

  def show
    @response = Response.find params[:id]
  end

  def edit
    @response = Response.find params[:id]
  end

  def update
    @response = Response.find params[:id]

    respond_to do | format |
      if @response.update_attributes response_params
        flash[:notice] = "Response updated successfully"
        format.html { redirect_to root_url }
      else
        flash[:error] = "Unable to update response. Please try again"
        format.html { render action: :edit }
      end
    end
  end

private
  def response_params
    params.require(:response).permit( 
      :id, :month, :year, :is_bug_exist, :bug_path, :time_when_bug_occured, :bug_summary, :bug_description, :primary_reason, :secondary_reason, :affected_stakeholders,
      :bug_created_by, :shift_timings, :tenure_of_employee_in_company, :technology_area, :employee_current_role, :bug_captured_by, :comments, :impact_of_bug
    )
  end
end
