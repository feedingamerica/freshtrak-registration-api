# frozen_string_literal: true

# A collection of family members / possible users
class Household < ApplicationRecord
    self.table_name = 'households'

    alias_attribute :id, :household_id

    belongs_to :household_members, foreign_key: :household_id, inverse_of: :households
    belongs_to :household_addresses, foreign_key: :household_id, inverse_of: :households
    belongs_to :household_event_registrations, foreign_key: :household_id, inverse_of: :households
end