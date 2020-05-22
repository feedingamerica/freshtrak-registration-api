# frozen_string_literal: true

# Creates a household for a user.
# Ensures that the household has a unique address.

class CreateHousehold
    attr_reader :household_name, :household_number, :household, :household_address, :address

    def initialize(household_name:, household_number:, address:)
        @household = Household.new(household_name: household_name,
                                    household_number: household_number,
                                    address: address)
    end

    def call
        return failure if address_already_taken?

        return failure unless household.save

        success
    rescue Faraday::Error => e
        household.errors.add(:freshtrak_registration_api, e.message)
        failure
    end

private

    def address_already_taken?
        address_already_taken = 
        household_addresses.where(address_line_1: address.address_line_1,
                                    address_line_2: address.address_line_2,
                                    city: address.city,
                                    state: address.state,
                                    zip_code: address.zip_code,
                                    zip_4: address.zip_4).exists?

        if address_already_taken
            household.errors.add(:household_id, 'Address already in use')
        end

        address_already_taken
    end

    def household_addresses
        @household_addresses ||= HouseholdAddress.all
      end

    def failure
        OpenStruct.new(success?: false, household: household,
                       errors: household.errors)
    end
    
    def success
    OpenStruct.new(success?: true, household: household,
                    errors: nil)
    end

end