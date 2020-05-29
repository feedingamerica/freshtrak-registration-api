class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.belongs_to :user_info
      t.belongs_to :user_credential
      t.string :identification_code, null: false
      t.string :uid, null: false
      t.string :provider, null: false
      t.integer :added_by, null: false
      t.integer :last_updated_by, null: false
      t.timestamps
    end
  end
end
