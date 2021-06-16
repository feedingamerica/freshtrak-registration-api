# frozen_string_literal: true

module Api
  # Exposes the Emails of user
  class EmailsController < Api::BaseController
    before_action :set_contact, only: %i[create index]
    before_action :find_email, only: %i[show]

    # POST  /api/emails
    def create
      @email = Email.new(email_params)
      if @email.save
        render json: ActiveModelSerializers::SerializableResource
          .new(@email).as_json
      else
        render json: { errors: @email.errors }
      end
    end

    # GET /emails/:id
    def show
      if @email
        render json: ActiveModelSerializers::SerializableResource
          .new(@email).as_json
      else
        render json: {}, status: :not_found
      end
    end

    # GET /api/emails
    def index
      @emails = @contact.emails

      render json:
        ActiveModelSerializers::SerializableResource
          .new(@emails).as_json
    end

    private

    def find_email
      @email = Email.find_by(id: params[:id])
    end

    def set_contact
      @contact = current_user.person.contacts.where(contact_type: 'email').first_or_create
    end

    # Only allow a trusted parameter "white list" through.
    def email_params
      params.require(:email).permit(
        :email, :is_primary, :permission_to_email
      ).merge(contact_id: @contact.id)
    end
  end
end
