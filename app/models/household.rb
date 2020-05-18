# frozen_string_literal: true

# A collection of family members / possible users
class Household < ApplicationRecord
    self.table_name = 'households'
    # Active Record implicitly creates the primary key as 'id.' We can alias with
    # the following line. Be sure to use the alias as a primary key when making
    # foreign key relationships with other tables.
    #self.primary_key = 'household_id'

    # Determines table relationships, "inverse_of" defines a two-way relation
    belongs_to :household_members, foreign_key: :id, inverse_of: :households
    belongs_to :household_addresses, foreign_key: :id, inverse_of: :households
    belongs_to :household_event_registrations, foreign_key: :id, inverse_of: :households

    # Sets a scope for all operations on the model.
    # default_scope { active } 
    # scope :active, -> { where("household_number > ?", 0) }
end