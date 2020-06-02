class CreateEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :emails do |t|
      t.references :location_type, foreign_key: true, null: false
      t.references :member, foreign_key: true, null: false
      t.string :email, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
