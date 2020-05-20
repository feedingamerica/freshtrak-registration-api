# frozen_string_literal: true

# A collection of family members / possible users
class Household < ApplicationRecord
    self.table_name = 'households'
    # Active Record implicitly creates the primary key as 'id.' We can alias with
    # the following line. Be sure to use the alias as a primary key when making
    # foreign key relationships with other tables.
    #self.primary_key = 'household_id'

    # Determines table relationships.
    has_one :household_address
    accepts_nested_attributes_for :household_address, :allow_destroy => true
    validates :name, :household_number, :presence => true

    # Sets a scope for all operations on the model.
    # default_scope { active } 
    # scope :active, -> { where("household_number > ?", 0) }
end