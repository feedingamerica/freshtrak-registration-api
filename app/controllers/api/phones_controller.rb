# frozen_string_literal: true

module Api
  # Exposes the Phones of user
  class PhonesController < Api::BaseController
    before_action :set_contact, only: %i[create index]
    before_action :find_phone, only: %i[show]

    # POST  /api/emails
    def create
      @phone = Phone.new(phone_params)
      if @phone.save
        render json: ActiveModelSerializers::SerializableResource
          .new(@phone).as_json
      else
        render json: { errors: @phone.errors }
      end
    end

    # GET /emails/:id
    def show
      if @phone
        render json: ActiveModelSerializers::SerializableResource
          .new(@phone).as_json
      else
        render json: {}, status: :not_found
      end
    end

    # GET /api/emails
    def index
      @phones = @contact.phones

      render json:
        ActiveModelSerializers::SerializableResource
          .new(@phones).as_json
    end

    private

    def find_phone
      @phone = Phone.find_by(id: params[:id])
    end

    def set_contact
      @contact = current_user.person.contacts.where(contact_type: 'phone').first_or_create
    end

    # Only allow a trusted parameter "white list" through.
    def phone_params
      params.require(:phone).permit(
        :phone, :is_primary, :permission_to_phone
      ).merge(contact_id: @contact.id)
    end
  end
end
