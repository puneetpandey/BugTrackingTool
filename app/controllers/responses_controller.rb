class ResponsesController < ApplicationController
  def index
    @responses = current_user.responses
  end

  def new
    @response = current_user.responses.new
  end
end
