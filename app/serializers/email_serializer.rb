# frozen_string_literal: true

# Defines Email attributes to be returned in JSON
class EmailSerializer < ApplicationSerializer
  attributes :id, :email, :is_primary, :permission_to_email
end
