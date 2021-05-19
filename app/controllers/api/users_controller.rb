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
      current_user.save
      build_family_and_members
      @family_members.save
      build_person
      @person.save
    end

    def build_identity
      @current_user.identities.new(identity_params)
    end

    def build_family_and_members
      @family = Family.new
      @family_members = @family.family_members.new
    end

    def build_person
      @person = Person.new(
        user_id: current_user.id,
        family_member_id: @family_members.id
      )
      @phone =  @person.phones.new(phone: @auth['phone_number'])
      @email =  @person.emails.new(email: @auth['cognito:username'])
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
