class AddIndexToMemberEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :members, :email, unique: true
  end
end
