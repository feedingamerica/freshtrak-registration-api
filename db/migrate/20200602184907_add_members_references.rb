class AddMembersReferences < ActiveRecord::Migration[6.0]
  def change
    add_reference :members, :gender, foreign_key: true, null: false
    add_reference :members, :suffix, foreign_key: true, null: true
  end
end
