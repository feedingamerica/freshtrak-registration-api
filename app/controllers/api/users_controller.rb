# frozen_string_literal: true

module Api
  # Endpoints for interacting with a User
  #   handled as a singular resource
  #   where the user is inferred from the auth token
  class UsersController < Api::BaseController
    # GET /api/users
    def show
      render json: current_user
    end

    # POST /api/users/sign_in
    def sign_in
      if current_user
        render json: { message: 'User Already Registered', user: current_user }
      else
        create_user_with_nested_models
        if current_user
          render json: {
            message: 'User Registered Successfully', user: current_user
          }
        end
      end
    end

    private

    def create_user_with_nested_models
      @current_user = User.create(user_type: :customer)
      @current_user.identities.create(identity_params)
      @person = Person.create(user_id: current_user.id)
      build_family
      build_contacts
    end

    def build_family
      @family = Family.create
      @family_member = FamilyMember.create(
        family_id: @family.id, person_id: @person.id,
        is_primary_member: true
      )
    end

    def build_contacts
      %w[email phone].each do |type|
        if type == 'email'
          email_obj = @family.contacts.create(contact_type: type)
          Email.create(contact_id: email_obj.id, email: @auth['email'])
        else
          phone_obj = @family.contacts.create(contact_type: type)
          Phone.create(contact_id: phone_obj.id, phone: @auth['phone_number'])
        end
      end
    end

    def identity_params
      {
        'provider_uid': @auth['sub'],
        'provider_type': @auth['identities'] ? @auth['identities'][0]['providerName'].downcase : 'cognito',
        'auth_hash': ''
      }
    end
  end
end
