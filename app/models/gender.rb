# frozen_string_literal: true

# Gender reference class
class Gender < ApplicationRecord
  validates :name, presence: true
end
