# frozen_string_literal: true

# A collection of family members / possible users
class Household < ApplicationRecord
  # Active Record implicitly creates the primary key as 'id.'

  # Determines table relationships. We can alias household_address -> address
  has_one :household_address, inverse_of: :household, dependent: :destroy
  # Allows the household controller to create a household_address
  # record when supplied in the payload.
  accepts_nested_attributes_for :household_address, allow_destroy: true
  before_validation :set_identification_code, on: :create

  validates :identification_code, presence: true,
                                  uniqueness: { case_sensitive: true }

  # Validations for the model
  validates :household_address, presence: true
  validates :name, presence: true
  validates :number, presence: true

  # Sets a scope for all operations on the model.
  # default_scope { active }
  # scope :active, -> { where("household_number > ?", 0) }
  def set_identification_code
    loop do
      self.identification_code = SafeRandom.generate_code(6)

      break unless Household.find_by(identification_code: identification_code)
    end
  end
end
