class AddCredentialsForeignKeyToUsers < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :credential, foreign_key: true, null: false
  end
end
