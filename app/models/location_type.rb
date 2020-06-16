# frozen_string_literal: true

# Location Type reference class
class LocationType < ApplicationRecord
  validates :name, presence: true
end
