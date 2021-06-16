# frozen_string_literal: true

# Defines Contact attributes to be returned in JSON
class ContactSerializer < ApplicationSerializer
  attributes :id, :contact_type

  has_many :emails, if: -> { object.emails.present? }
  has_many :phones, if: -> { object.phones.present? }
end
