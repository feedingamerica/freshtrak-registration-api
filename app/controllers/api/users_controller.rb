# frozen_string_literal: true

module Api
  # Endpoints for interacting with a User
  #   handled as a singular resource
  #   where the user is inferred from the auth token
  class UsersController < Api::BaseController
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
  end
end
