# frozen_string_literal: true

# Alt Id Type Reference class
class AltIdType < ApplicationRecord
  validates :name, presence: true
  validates :description, length: { maximum: 100 }
end