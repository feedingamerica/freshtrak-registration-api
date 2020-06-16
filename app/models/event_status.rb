# frozen_string_literal: true

# Event Status reference class
class EventStatus < ApplicationRecord
  validates :name, presence: true
end
