# frozen_string_literal: true

# Defines Phone attributes to be returned in JSON
class PhoneSerializer < ApplicationSerializer
  attributes :id, :phone, :is_primary, :permission_to_text
end
