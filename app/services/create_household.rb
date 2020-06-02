# frozen_string_literal: true

# Ultimately, creates a household for a user
# A member object is created for the user object in order
# to associate a user to a household. 
class CreateHousehold
    attr_reader :household
  
    def initialize(name:, number:, address:, current_user:)
        @member = current_user.create_member(number: 1,
                                            first_name: current_user.first_name,
                                            middle_name: current_user.middle_name,
                                            last_name: current_user.last_name,
                                            date_of_birth: current_user.date_of_birth,
                                            email: current_user.email,
                                            added_by: current_user.id
        )
      @household = Household.new(name: name,
                                number: number,
                            address_attributes: {
                                line_1: address.line_1,
                                line_2: address.line_2,
                                city:   address.city,
                                state:  address.state,
                                zip_code: address.zip_code,
                                zip_4:  address.zip_4
                            })
                            .members.push(@member)
    end
  
    def call

      return failure unless household.save
  
      success
    rescue Faraday::Error => e
      household.errors.add(:household_id, e.message)
      failure
    end
  
    private
  
    def member_email_already_exists?
      member_email_already_exists =
        Members.where(email: @member.email).exists?
  
      if member_email_already_exists
        household.errors.add(:member_id, 'email already exists')
      end
  
      member_email_already_exists
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
  