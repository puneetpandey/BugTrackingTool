class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username, unique: true, null: false
      t.integer :signed_in_count, default: 0
      t.timestamps null: false
    end
    add_index :users, :username
  end
end
