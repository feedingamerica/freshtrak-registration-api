# frozen_string_literal: true

module Api
  # Manages the user Profiles
  class ProfilesController < Api::BaseController
    # GET user details
    def user_data
      user_data_hash = {}
      user_data_hash = get_user_name(user_data_hash)
      user_data_hash['is_adult'] = current_user.is_adult
      user_data_hash['dob'] = current_user.date_of_birth
      user_data_hash['race'] = current_user.race
      user_data_hash['ethnicity'] = current_user.ethnicity
      user_data_hash['gender'] = current_user.gender
      data_hashing(user_data_hash)
    end

    # GET user address
    def user_address
      user_address_hash = {}
      user_address_hash['address1'] = current_user.address_line_1
      user_address_hash['address2'] = current_user.address_line_2
      user_address_hash['city'] = current_user.city
      user_address_hash['state'] = current_user.state
      user_address_hash['zipcode'] = current_user.zip_code
      data_hashing(user_address_hash)
    end

    # GET user contact details
    def user_contact_details
      user_contact_hash = {}
      user_contact_hash['phone'] = current_user.phone
      user_contact_hash['email'] = current_user.email
      data_hashing(user_contact_hash)
    end

    # GET user vehicle details
    def user_vehicle_details
      user_vehicle_hash = {}
      user_vehicle_hash['vehicle_number'] = current_user.license_plate
      data_hashing(user_vehicle_hash)
    end

    # PUT/PATCH user data
    def update_user_data
      if user_params.present? && current_user.update(user_params)
        render_message('Changes updated succesfully', 200)
      else
        render_message('Error in Data', 500)
      end
    end

    private

    def data_hashing(hash_data)
      user_data = []
      user_data << hash_data
      render_set_collection(user_data)
    end

    def get_user_name(user_data_hash)
      user_data_hash['first_name'] = current_user.first_name
      user_data_hash['middle_name'] = current_user.middle_name
      user_data_hash['last_name'] = current_user.last_name
      user_data_hash
    end

    def user_params
      params.require(:user).permit(
        :first_name, :middle_name, :last_name, :date_of_birth,
        :gender, :phone, :email, :address_line_1, :address_line_2,
        :city, :state, :zip_code, :license_plate, :race, :ethnicity
      )
    end
  end
end
