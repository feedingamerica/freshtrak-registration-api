# frozen_string_literal: true

# Carrier Type reference class
class CarrierType < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true
end
