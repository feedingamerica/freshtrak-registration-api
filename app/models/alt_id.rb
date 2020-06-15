# frozen_string_literal: true

# Alt Ids for Household Members
class AltId < ApplicationRecord
  belongs_to :member, inverse_of: :alt_id
  belongs_to :alt_id_type

  validates :value, presence: true, length: { maximum: 100 }
  validates :alt_id_type_id, presence: true
end