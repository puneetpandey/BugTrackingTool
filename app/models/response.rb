class Response < ActiveRecord::Base
  STATUS = { pending: 1, completed: 2, approved: 3, referred_back: 4 }
  PREVIOUS_MONTH = Date.today.prev_month.month
  YEAR = Date.today.prev_month.month == 12 ? Date.today.year - 1 : Date.today.year

  ## Validations

  belongs_to :project
  belongs_to :user
  #belongs_to :awaiting_response, class: "User"
end
