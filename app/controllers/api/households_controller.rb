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
            @household = Household.new(household_params)
            @household.save
            render json: @household
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
        
        def household_params
            params.require(:household).permit(:household_number, :name, :added_by, :last_updated_by)
        end
    end
end
