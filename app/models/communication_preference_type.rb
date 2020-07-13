# frozen_string_literal: true

# Communication Preference Type reference class
class CommunicationPreferenceType < ApplicationRecord
  validates :name, presence: true
end
