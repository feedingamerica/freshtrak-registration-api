# frozen_string_literal: true

module Api
    # Exposes the Household data
    class HouseholdsController < ApplicationController
        before_action :set_household, only: [:update]
        # GET
        def index
            @household = Household.all
            render json: @household
        end

        # POST
        def create
            @household = Household.new(household_params)
            @household.save
            render json: @household
        end

        private
        def set_household
            @household = Household.find(params[:id]) 
        end
        
        def household_params
            params.require(:household).permit(:household_number, :name, :added_by, :last_updated_by)
        end
    end
end
