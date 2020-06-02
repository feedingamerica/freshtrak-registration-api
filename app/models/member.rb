# frozen_string_literal: true

# The members of a household. Correlates to Users.
class Member < ApplicationRecord
    belongs_to :household, inverse_of: :members
    belongs_to :user, inverse_of: :member

    validate :household_id_exists

    private
    def household_id_exists
      return false if Household.find_by_id(self.household_id).nil?
    end
  end
  