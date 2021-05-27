# frozen_string_literal: true

module Api
  # Exposes the Addresses of user
  class AddressesController < Api::BaseController
    before_action :set_contact, only: %i[create show]

    # POST api/address
    def create
      @address = Address.first_or_initialize(address_params)
      if @address.save
        render json: @address
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end

    # GET /api/address
    def show
      render json:
        ActiveModelSerializers::SerializableResource
          .new(@address).as_json
    end

    private

    def set_contact
      family = Family.by_person_id(current_user.person.id).first
      @contact = family.contacts.where(contact_type: 'address').first_or_create
      @address = @contact.address
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit(
        :line_1, :line_2, :city, :state, :zip_code
      ).merge(contact_id: @contact.id)
    end
  end
end
