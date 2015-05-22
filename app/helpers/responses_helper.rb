module ResponsesHelper
  PATHS = {
    "PATH ONE" => "PATH ONE", "PATH TWO" => "PATH TWO", "PATH THREE" => "PATH THREE", "PATH FOUR" => "PATH FOUR"
  }

  BUG_SUMMARY = {
    "Task executed but exceed the duration" => "Task executed but exceed the duration",
    "Task executed but in a worng manner" => "Task executed but in a worng manner",
    "Task executed which wasn't required" => "Task executed which wasn't required",
    "Task executed but in wrong order" => "Task executed but in wrong order",
    "Task left incomleted by the Employee" => "Task left incomleted by the Employee"
  }

  REASON_FOR_BUG = {
    "Carelessness" => "Carelessness", "Environmental issues" => "Environmental issues", "Ignorance" => "Ignorance",
    "Lack of training" => "Lack of training", "Required skill/s were missing" => "Required skill/s were missing",
    "Employee is tagged in wrong role" => "Employee is tagged in wrong role", "In-experience to respond to the situation" => "In-experience to respond to the situation"
  }

  AFFECTED_STAKEHOLDER = {
    "Client" => "Client", "Client's Customer" => "Client's Customer", "Organization Internal Users" => "Organization Internal Users", "Organization Customers" => "Organization Customers"
  }

  SHIFT_TIMINGS = {
    "Day shift" => "Day shift", "Evening shift" => "Evening shift", "Night shift" => "Night shift"
  }

  EMPLOYEE_TENURE = {
    "0-6 Months" => "0-6 Months", "6-12 Months" => "6-12 Months", "1+ Year" => "1+ Year", "2+ Years" => "2+ Years", "3+ Years" => "3+ Years", "5+ Years" => "5+ Years"
  }

  TECHNOLOGY_AREA = {
    "Front End" => [ "HTML", "CSS", "JAVASCRIPT", "NodeJS", "AngularJS" ],
    "Back End" => [ "JAVA", ".NET", "Ruby", "PYTHON", "PHP", "Objective-C" ],
    "Frameworks" => [ "SWING", "SPRING", "STRUTS", "Rails", "Cake PHP" ],
    "Databases" => [ "MySQL", "MS-SQL", "PostGres", "Sqlite-3", "Hadoop", "MongoDB" ]
  }

  def populate_date_options
    months_arr = []
    if (1..6).include?(Date.today.day)
      year = Date::MONTHNAMES[Date.today.prev_month.month] == "December" ? Date.today.year - 1 : Date.today.year
      months_arr.push(Date::MONTHNAMES[Date.today.prev_month.month].to_s + "-" + year.to_s)
    end
    months_arr.push(Date::MONTHNAMES[Date.today.month].to_s + "-" + Date.today.year.to_s)
    select(:response, :month_year, months_arr, { prompt: "Month for which Bug is reported (Choose from the options)" }, { class: "form-control" })
  end

  def populate_path_options question, path_desc
    select :response, question.to_sym, PATHS, { prompt: "#{path_desc} (Choose from the options)" }, { class: "form-control" }
  end

  def populate_primary_cause question, path_desc
    select(:response, question.to_sym, REASON_FOR_BUG, { prompt: "#{path_desc} (Choose from the options)" }, { class: "form-control" })
  end

  def populate_secondary_cause question, path_desc
    select(:response, question.to_sym, REASON_FOR_BUG.merge({"None (No secondary cause)" => "None (No secondary cause)"}), { prompt: "#{path_desc} (Choose from the options)" }, { class: "form-control" })
  end

  def populate_affected_stakeholder question, path_desc
    select(:response, question.to_sym, AFFECTED_STAKEHOLDER, { prompt: "#{path_desc} (Choose from the options)" }, { class: "form-control" })
  end

  def populate_shift_timings_options question, path_desc
    select(:response, question.to_sym, SHIFT_TIMINGS, { prompt: "#{path_desc} (Choose from the options)" }, { class: "form-control" })
  end

  def populate_employee_tenure_options question, path_desc
    select(:response, question.to_sym, EMPLOYEE_TENURE, { prompt: "#{path_desc} (Choose from the options)" }, { class: "form-control" })
  end

  def populate_technology_area question, path_desc
    select(:response, question.to_sym, grouped_options_for_select(TECHNOLOGY_AREA), { prompt: "#{path_desc} (Choose from the options)" }, { class: "form-control" })
  end
end
