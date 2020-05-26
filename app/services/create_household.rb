# frozen_string_literal: true

# Creates a household for a user.
# Ensures that the household has a unique address per zip code.

class CreateHousehold
    attr_reader :household_name, :household_number, :address, :household, :household_address

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
    # May want to put more thought into this validation if 
    # a family changes addresses. 
    def address_already_taken?
        address_already_taken = 
        household_addresses.where(address_line_1: household.address.address_line_1,
                                    address_line_2: household.address.address_line_2,
                                    city: household.address.city,
                                    state: household.address.state,
                                    zip_code: household.address.zip_code,
                                    zip_4: household.address.zip_4).exists?

        if address_already_taken
            #TODO: Replace household_id with user_id once we get it in place.
            household.errors.add(:household_id, 'Address already in use')
        end

        address_already_taken
    end

    def household_addresses
        search_zip = household.address.zip_code
        @household_addresses ||= HouseholdAddress.where(zip_code: search_zip)
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