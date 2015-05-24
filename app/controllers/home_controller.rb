class HomeController < ApplicationController
  def dashboard
  end

  def coming_soon
    render layout: 'coming_soon'
  end
end
