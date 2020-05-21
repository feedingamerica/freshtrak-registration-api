# frozen_string_literal: true

# A collection of family members / possible users
class Household < ApplicationRecord
    # Active Record implicitly creates the primary key as 'id.' 

    # Determines table relationships. We can alias household_address -> address
    has_one :address, class_name: "HouseholdAddress"
    # Allows the household controller to create a household_address record when supplied
    # in the payload.
    accepts_nested_attributes_for :address

    # Sets a scope for all operations on the model.
    # default_scope { active } 
    # scope :active, -> { where("household_number > ?", 0) }
end