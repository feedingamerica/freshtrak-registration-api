# frozen_string_literal: true

# Migration to create the households table
class CreateHouseholds < ActiveRecord::Migration[6.0]
  # This class is generated after running "jets db:generate create_households"
  # The command on its own will generate a migration class that initially,
  # only creates the table. Additional columns can be added after running
  # the create command.
  def change
    # Implicitly creates an id field for primary key
    create_table :households do |t|
      t.integer :number, null: false
      t.string :name, null: false
      t.string :identification_code, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.integer :deleted_by, null: true
      t.datetime :deleted_on, null: true
      t.index :identification_code, unique: true
      t.timestamps
    end
  end
end
