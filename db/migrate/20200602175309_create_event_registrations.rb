class CreateEventRegistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :event_registrations do |t|
      t.belongs_to :household, index: { unique: true }, foreign_key: true
      t.integer :event_slot_id, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
