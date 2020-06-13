# frozen_string_literal: true
#
# User information
class UserDetail < ApplicationRecord
  belongs_to :user, inverse_of: :user_detail

  validates :name, presence: true
  validates :user_id, presence: true
end