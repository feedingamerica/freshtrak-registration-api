class CreateSuffixes < ActiveRecord::Migration[6.0]
  def change
    create_table :suffixes do |t|
      t.string :name, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
    end
  end
end
