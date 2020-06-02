class AddUserDetailsToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :users, :user_detail, foreign_key: true, null: false
  end
end
