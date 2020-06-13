class CreateEventStatuses < ActiveRecord::Migration[6.0]
  def change
    create_table :event_statuses do |t|
      t.string :name, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
