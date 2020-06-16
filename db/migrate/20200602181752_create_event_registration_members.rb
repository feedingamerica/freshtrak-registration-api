# frozen_string_literal: true

# Create Event Registration Members table
class CreateEventRegistrationMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :event_registration_members do |t|
      t.belongs_to :event_registration,
                   index: { unique: true },
                   foreign_key: true
      t.belongs_to :member, index: { unique: true }, foreign_key: true
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
