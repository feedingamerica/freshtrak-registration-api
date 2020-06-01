class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.belongs_to :household, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.string :first_name, null: false
      t.string :middle_name
      t.string :last_name, null: false
      t.datetime :date_of_birth, null: false
      t.boolean :is_head_of_household, null: false, default: false
      t.string :email, null: false
      t.boolean :is_active, null: false, default: true
      t.string :added_by, null: false
      t.datetime :last_update
    end
  end
end
