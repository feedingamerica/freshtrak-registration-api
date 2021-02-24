# frozen_string_literal: true

module Api
  class ProfilesController < Api::BaseController
    # GET user details 
    def user_data
      user_data = []
      user = current_user
      user_data_hash = {}
      user_data_hash["first_name"] = user.first_name
      user_data_hash["middle_name"] = user.middle_name
      user_data_hash["last_name"] = user.last_name
      user_data_hash["is_adult"] = user.is_adult
      user_data_hash["dob"] = user.date_of_birth
      user_data_hash["race"] = user.race
      user_data_hash["ethnicity"] = user.ethnicity
      user_data_hash["gender"] = user.gender
      user_data << user_data_hash
      render_set_collection(user_data)
    end

    # GET user address
    def user_address
      user_address_data = []
      user = current_user
      user_address_hash = {}
      user_address_hash["address1"] = user.address_line_1
      user_address_hash["address2"] = user.address_line_2
      user_address_hash["city"] = user.city
      user_address_hash["state"] = user.state
      user_address_hash["zipcode"] = user.zip_code
      user_address_data << user_address_hash
      render_set_collection(user_address_data)
    end

    # GET user contact details
    def user_contact_details
      user_contact_data = []
      user = current_user
      user_contact_hash = {}
      user_contact_hash["phone"] = user.phone
      user_contact_hash["email"] = user.email
      user_contact_data << user_contact_hash
      render_set_collection(user_contact_data)
    end

    # GET user vehicle details
    def user_vehicle_details
      user_vehicle_data = []
      user = current_user
      user_vehicle_hash = {}
      user_vehicle_hash["vehicle_number"] = user.license_plate
      user_vehicle_data << user_vehicle_hash
      render_set_collection(user_vehicle_data)
    end

    # PUT/PATCH user data
    def update_user_data
      if user_params.present? && current_user.update(user_params)
        render_message("Changes updated succesfully", 200)
      else
        render_message("Error in Data", 500)
      end
    end

    private

    def user_params
      params.require(:user).permit(
        :first_name, :middle_name, :last_name,:date_of_birth,
        :gender, :phone, :email, :address_line_1, :address_line_2,
        :city, :state, :zip_code, :license_plate, :race, :ethnicity)
    end
  end  
end

