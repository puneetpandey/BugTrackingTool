class CreateProjectMemberships < ActiveRecord::Migration
  def change
    create_table :project_memberships do |t|
      t.belongs_to :user, null: false
      t.belongs_to :project, null: false
      t.string :role
      t.boolean :is_active
      t.date :billable_from
      t.date :billable_to
      t.timestamps null: false
    end
  end
end
