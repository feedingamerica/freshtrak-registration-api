# frozen_string_literal: true

# Defines Address attributes to be returned in JSON
class AddressSerializer < ApplicationSerializer
  attributes :id, :line_1, :line_2, :city, :state, :zip_code
end
