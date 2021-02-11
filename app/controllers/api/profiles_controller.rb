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
      user_data_hash["age"] = Date.today.year - user.date_of_birth.year
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
      user = current_user
      user.update(first_name: params[:first_name], 
                        middle_name: params[:middle_name],
                        last_name: params[:last_name],
                        is_adult: params[:is_adult],
                        date_of_birth: params[:date_of_birth],
                        race: params[:race],
                        ethnicity: params[:ethnicity],
                        gender: params[:gender])
      render_message('Changes updated succesfully', 200)
    end

    # PUT/PATCH user address
    def update_user_address
      user = current_user
      user.update(address_line_1: params[:address_line_1], 
                        address_line_2: params[:address_line_2],
                        city: params[:city],
                        state: params[:state],
                        zip_code: params[:zip_code])
      render_message('Changes updated succesfully', 200)
    end

    # PUT/PATCH user contact details
    def update_user_contact
      user = current_user
      user.update(phone: params[:phone], 
                        email: params[:email])
      render_message('Changes updated succesfully', 200)
    end

    # PUT/PATCH user contact details
    def update_user_vehicle
      user = current_user
      user.update(license_plate: params[:license_plate])
      render_message('Changes updated succesfully', 200)
    end
  end  
end

