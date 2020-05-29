# frozen_string_literal: true

module Api
  # Exposes the Household data
  class HouseholdsController < ApplicationController
    before_action :set_household, only: %i[show update delete]
    # GET /households
    def index
      # Should get household by current user_id/member_id
      render json: { 'household': '0' }
    end

    # GET /households/1
    def show
      if @household
        render json: @household
      else
        render json: {}, status: :not_found
      end
    end

    # POST /households
    def create
      if @household == Household.create(household_params)
        render json: @household
      else
        render json: @household.errors, status: :unprocessable_entity
      end
    end

    # PUT /households/1
    def update
      if @household.update(household_params)
        render json: @household
      else
        render json: @household.errors, status: :unprocessable_entity
      end
    end

    # DELETE /households/1
    def delete
      if @household.destroy
        render json: { deleted: true }
      else
        render json: @household.errors, status: :unprocessable_entity
      end
    end

    private

    def set_household
      @household = Household.find(params[:id])
    end

    # The following requires certain parameters be sent when making requests
    # to this controller. Nested models must have "_attributes" appended to
    # the model name in the "permit" as well as the payload to the controller.
    def household_params
      params.require(:household).permit(:household_number, :household_name,
                                        address_attributes: %i[id address_line_1
                                                               address_line_2
                                                               city
                                                               state
                                                               zip_code
                                                               zip_4
                                                               _destroy])
    end
  end
end
