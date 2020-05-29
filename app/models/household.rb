# frozen_string_literal: true

# A collection of family members / possible users
class Household < ApplicationRecord
  # Active Record implicitly creates the primary key as 'id.'

  # Determines table relationships. We can alias household_address -> address
  has_one :address, class_name: 'HouseholdAddress', dependent: :destroy
  # Allows the household controller to create a household_address
  # record when supplied in the payload.
  accepts_nested_attributes_for :address, allow_destroy: true

  before_validation :set_added_by, on: :create

  # Validations for the model
  validates :address, presence: true

  # Sets a scope for all operations on the model.
  # default_scope { active }
  # scope :active, -> { where("household_number > ?", 0) }

  private

  def set_added_by
    self.added_by = 0
    self.last_updated_by = 0
  end
end
