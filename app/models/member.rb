# frozen_string_literal: true

# The members of a household. Correlates to Users.
class Member < ApplicationRecord
    belongs_to :household, inverse_of: :member
    belongs_to :user, inverse_of: :member
  end
  