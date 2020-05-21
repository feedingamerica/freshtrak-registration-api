# frozen_string_literal: true

# The address associated with a household
class HouseholdAddress < ApplicationRecord
    belongs_to :household
end