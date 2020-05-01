class CreateReservations < ActiveRecord::Migration[6.0]
  def change
    create_table :reservations do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :event_date_id

      t.timestamps
    end
    add_index :reservations, :event_date_id
  end
end
