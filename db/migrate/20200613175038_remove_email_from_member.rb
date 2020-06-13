class RemoveEmailFromMember < ActiveRecord::Migration[6.0]
  def change
    remove_column :members, :email, :string
    end
end
