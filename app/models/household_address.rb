# frozen_string_literal: true

# The address associated with a household
class HouseholdAddress < ApplicationRecord
  belongs_to :household

  before_validation :set_added_by, on: :create

  private

  def set_added_by
    self.added_by = 0
    self.last_updated_by = 0
  end
end
