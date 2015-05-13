class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.belongs_to :location
      t.integer :team_size
      t.text :description
      t.timestamps null: false
    end
    add_index :projects, :name
  end
end
