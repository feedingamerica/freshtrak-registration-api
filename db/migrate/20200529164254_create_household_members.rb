class CreateHouseholdMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :household_members do |t|
      t.belongs_to :household, index: { unique: true }, foreign_key: true
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.belongs_to :suffix, index: { unique: true }, foreign_key: true
      t.belongs_to :gender, index: { unique: true }, foreign_key: true
      t.integer :household_member_number, null: false
      t.string :first_name, null: false
      t.string :middle_name, null: true
      t.string :last_name, null: false
      t.datetime :date_of_birth, null: false
      t.boolean :is_head_of_household, default: false
      t.string :email, null: false
      t.boolean :is_active_member, default: true
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
