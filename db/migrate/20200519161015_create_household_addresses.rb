class CreateHouseholdAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :household_addresses do |t|
      t.belongs_to :household, index: { unique: true }, foreign_key: true
      t.string  :address_line_1
      t.string  :address_line_2
      t.string  :city
      t.string  :state
      t.string  :zip_code
      t.string  :zip_4
      t.integer :added_by
      t.integer :last_updated_by
      t.timestamps
    end
  end
end
