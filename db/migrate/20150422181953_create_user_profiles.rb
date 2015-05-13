class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.belongs_to :user, null: false
      t.integer :employee_id, unique: true, null: false
      t.string :designation
      t.integer :manager_employee_id, null: false
      t.string :mobile
      t.belongs_to :location
      t.timestamps null: false
    end
    add_index :user_profiles, :employee_id
    add_index :user_profiles, :designation
    add_index :user_profiles, :mobile
  end
end
