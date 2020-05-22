# frozen_string_literal: true

module Api
    # Exposes the Household data
    class HouseholdsController < ApplicationController
        before_action :set_household, only: [:show, :update, :delete]
        
        # GET /households
        def index
            @household = Household.all
            render json: @household
        end

        # GET /households/1
        def show
            render json: @household
        end

        # POST /households
        def create
            result = CreateHousehold.new(
                household_name: household_params[:household_name],
                household_number: household_params[:household_number],
                address: household_params[:address_attributes]
            ).call
            @household = result.household

            if result.success?
                render json: @household , status: :created
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
            @household.destroy
            render json: { deleted: true }
        end

        private
        def set_household
            @household = Household.find(params[:id]) 
        end
        
        # The following requires certain parameters be sent when making requests
        # to this controller. Nested models must have "_attributes" appended to the model name
        # in the "permit" as well as the payload to the controller.
        def household_params
            params.require(:household).permit(:household_number, :household_name, 
                address_attributes: [:address_line_1, :address_line_2, :city, :state, :zip_code, :zip_4])
        end
    end
end
