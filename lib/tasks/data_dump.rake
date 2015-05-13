namespace :db do
  task data_dump: :environment do
    locations = [ { name: "Delhi", code: 100 }, { name: "Bangalore", code: 101 }, { name: "Mumbai", code: 102 }, { name: "Hyderabad", code: 103 } ]

    locations.each do | location_params |
      location = Location.new location_params

      if location.save
        p 'Location ' + location.name.to_s + ' is saved successfully'
      end
    end

    employee_ids = 1001

    users = [
      { first_name: "John", last_name: "Smith", username: "john_smith", email: "john_smith@example.com", password: "test@123", roles: [ :manager ] },
      { first_name: "Steve", last_name: "Dave", username: "steve_dave", email: "steve_dave@example.com", password: "test@123", roles: [ :manager ] },
      { first_name: "Mark", last_name: "Waugh", username: "mark_waugh", email: "mark_waugh@example.com", password: "test@123", roles: [ :manager ] },
      { first_name: "Daniel", last_name: "Bryan", username: "daniel_bryan", email: "daniel_bryan@example.com", password: "test@123", roles: [ :lead ] },
      { first_name: "Andrew", last_name: "Bishop", username: "andrew_bishop", email: "andrew_bishop@example.com", password: "test@123", roles: [ :lead ] },
      { first_name: "Chris", last_name: "Brown", username: "chris_brown", email: "chris_brown@example.com", password: "test@123", roles: [ :lead ] },
      { first_name: "Charles", last_name: "Smith", username: "charles_smith", email: "charles_smith@example.com", password: "test@123", roles: [ :lead ] },
      { first_name: "Tim", last_name: "Cook", username: "tim_cook", email: "tim_cook@example.com", password: "test@123", roles: [ :lead ] },
      { first_name: "De", last_name: "Villiers", username: "de_villiers", email: "de_villers@example.com", password: "test@123", roles: [ :lead ] },
      { first_name: "Shane", last_name: "Watson", username: "shane_watson", email: "shane_watson@example.com", password: "test@123", roles: [ :lead ] }
    ]

    users.each do | user_params |
      user = User.new user_params

      if user.save && user.reload
        p 'User ' + user.username.to_s + ' is saved successfully. Now creating profile information....'
        if user.has_role? :manager
          user_profile = user.build_user_profile employee_id: employee_ids, designation: "Project Manager", manager_employee_id: 0, mobile: "+(91)-120-5150556", location: Location.find_by_code(101)
        else
          manager = [ "daniel_bryan", "andrew_bishop", "chris_brown" ].include?(user.username) ? User.find_by_username( "john_smith" ).id : ( [ "charles_smith", "tim_cook" ].include?(user.username) ? User.find_by_username( "steve_dave" ).id : User.find_by_username( "mark_waugh" ).id )
          user_profile = user.build_user_profile employee_id: employee_ids, designation: "Lead", manager_employee_id: manager, mobile: "+(91)-120-5150556", location: Location.find_by_code(102)
        end

        if user_profile.save
          p 'Profile of user ' + user.username.to_s + ' is saved successfully'
          employee_ids += 1
        end
      end
    end

    projects = [
      { name: "Adobe", location: Location.find_by_code(100), team_size: 100, description: "Loreal ipsum" },
      { name: "Google", location: Location.find_by_code(101), team_size: 200, description: "Loreal ipsum" },
      { name: "Oracle", location: Location.find_by_code(102), team_size: 300, description: "Loreal ipsum" }
    ]

    projects.each do | project_params |
      project = Project.new project_params

      if project.save
        p 'Project ' + project.name.to_s + ' is saved successfully'
      end
    end
  end
end