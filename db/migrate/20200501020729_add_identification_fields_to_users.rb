class AddIdentificationFieldsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :last_name, :string
    add_column :users, :suffix, :string
    add_column :users, :date_of_birth, :date
    add_column :users, :gender, :string
    add_column :users, :phone, :string
    add_column :users, :permission_to_text, :boolean
    add_column :users, :email, :string
    add_column :users, :permission_to_email, :boolean
    add_column :users, :address_line_1, :string
    add_column :users, :address_line_2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip_code, :string
    add_column :users, :license_plate, :string
    add_column :users, :number_of_seniors_in_household, :integer
    add_column :users, :number_of_adults_in_household, :integer
    add_column :users, :number_of_children_in_household, :integer
    add_column :users, :identification_code, :string, null: false

    add_index :users, :identification_code, unique: true
  end
end
