class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.string :name
      t.string :college
      t.integer :year
      t.string :email
      t.string :phone
      t.string :pid

      t.timestamps
    end
  end
end
