class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.belongs_to      :user, null: false
      t.belongs_to      :project, null: false
      t.integer         :month
      t.integer         :year
      t.integer         :reference_key, unique: true, null: false
      t.integer         :status, null: false
      t.integer         :approval_owner
      t.boolean         :is_bug_exist
      t.string          :bug_path
      t.datetime        :time_when_bug_occured
      t.string          :bug_summary
      t.text            :bug_description
      t.string          :primary_reason
      t.string          :secondary_reason
      t.string          :affected_stakeholders
      t.string          :bug_created_by
      t.string          :shift_timings
      t.string          :tenure_of_employee_in_company
      t.string          :technology_area
      t.string          :employee_current_role
      t.string          :bug_captured_by
      t.text            :comments
      t.string          :impact_of_bug
      t.timestamps null: false
    end
  end
end
