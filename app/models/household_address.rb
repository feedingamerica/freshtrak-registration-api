# frozen_string_literal: true

# The address associated with a household
class HouseholdAddress < ApplicationRecord
    self.table_name = 'household_addresses'

    belongs_to :household, foreign_key: :household_id
    validates :household_id, :presence => true
end