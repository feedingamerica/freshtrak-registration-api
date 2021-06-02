# frozen_string_literal: true

# Suffix reference class
class Suffix < ApplicationRecord
  # Validation for the model
  validates :name, presence: true
end
