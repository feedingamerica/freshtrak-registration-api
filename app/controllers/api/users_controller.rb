# frozen_string_literal: true

module Api
  # Endpoints for interacting with a User
  #   handled as a singular resource
  #   where the user is inferred from the auth token
  class UsersController < Api::BaseController
    # POST /api/user
    def create
      if current_user
        render json: { message: 'User Already Registered', user: current_user }
      else
        @current_user = User.new(user_type: :customer)
        sign_in
        if current_user
          render json: { message: 'User Registered Successfully', user: current_user }
        end
      end
    end

    # GET /api/user
    def show
      render json: current_user
    end

    # PATCH/PUT /api/user
    def update
      if current_user.update(user_params)
        render json: current_user
      else
        render json: current_user.errors, status: :unprocessable_entity
      end
    end

    private

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(
        :first_name, :middle_name, :last_name, :suffix, :date_of_birth,
        :gender, :phone, :permission_to_text, :email, :permission_to_email,
        :address_line_1, :address_line_2, :city, :state, :zip_code,
        :license_plate, :seniors_in_household, :adults_in_household,
        :children_in_household
      )
    end

    def sign_in
      build_and_save_nested_models
    end

    def build_and_save_nested_models
      build_identity
      build_family
      build_contacts
      build_email
      build_phone
    end

    def build_identity
      @current_user.identities.new(identity_params)
      @current_user.save
    end

    def build_family
      @family = Family.new
      @family.save
    end

    def build_contacts
      @contact = @family.contacts.new(contact_type: 'email')
      @contact.save
    end

    def build_email
      @email = Email.new(contact_id: @contact.id, email: 'email@gmail.com')
      @email.save
    end

    def build_phone
      @phone = Phone.new(contact_id: @contact.id, phone: '2034916636')
      @phone.save
    end

    def build_person
      @person = Person.new(
        user_id: current_user.id
      )
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
