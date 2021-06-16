# frozen_string_literal: true

module Api
  # Exposes the Addresses of user
  class AddressesController < Api::BaseController
    before_action :set_contact, only: %i[create show]

    # POST api/address
    def create
      @address = Address.where(address_params).first_or_initialize
      if @address.save
        render json: serialized_address
      else
        render json: @address.errors, status: :unprocessable_entity
      end
    end

    # GET /api/address
    def show
      @address = @contact.address

      render json: serialized_address
    end

    private

    def set_contact
      @contact = current_user.person.contacts.where(contact_type: 'address').first_or_create
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit(
        :line_1, :line_2, :city, :state, :zip_code
      ).merge(contact_id: @contact.id)
    end

    def serialized_address
      return unless @address

      ActiveModelSerializers::SerializableResource.new(@address).as_json
    end
  end
end
