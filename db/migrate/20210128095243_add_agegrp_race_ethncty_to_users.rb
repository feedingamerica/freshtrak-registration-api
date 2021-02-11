class AddAgegrpRaceEthnctyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :age_group, :string, default: "Adult"
    add_column :users, :race, :string
    add_column :users, :ethnicity, :string
    add_column :users, :is_adult, :boolean
  end
end
