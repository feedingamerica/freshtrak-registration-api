
class CreateHouseholds < ActiveRecord::Migration[6.0]
# This class is generated after running "jets db:generate create_households"
# The command on its own will generate a migration class that initially,
# only creates the table. Additional columns can be added after running 
# the create command.
  def change
    # Implicitly creates an id field for primary key
    create_table :households do |t|
      t.integer :household_number, null: false
      t.string :household_name, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      # Creates created_at and updated_at columns. These are managed automatically
      t.timestamps
    end
  end
end
