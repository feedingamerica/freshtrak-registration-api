# frozen_string_literal: true

module PantryTrak
  # class handling Users for PantryTrak Client (validations, attributes, etc.)
  class User
    include ActiveModel::Model
    include ActiveModel::Validations

    attr_accessor :id, :user_type, :first_name, :middle_name, :last_name,
                  :suffix, :gender, :phone, :email, :address_line_1,
                  :address_line_2, :city, :state, :zip_code, :license_plate,
                  :seniors_in_household, :adults_in_household,
                  :children_in_household, :permission_to_email,
                  :permission_to_phone, :date_of_birth, :identification_code

    validates :id, :identification_code, presence: true
  end
end
