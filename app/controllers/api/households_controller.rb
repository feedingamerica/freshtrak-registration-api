# frozen_string_literal: true

module Api
  # Exposes the Household data
  class HouseholdsController < Api::BaseController
    before_action :set_household, only: %i[show update delete]
    # GET /households
    # def index
    #   # Should get household by current user_id/member_id
    #   @household = Household.joins(:members)
    #   .where(members: { id: current_user.member.id })
    #   render json: @household
    # end

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
      @household = Household.new(household_params)
      set_added_by
      if @household.save
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

    def set_added_by
      @household.added_by = current_user.id
      @household.last_updated_by = current_user.id
      return unless @household.address

      @household.address.added_by = current_user.id
      @household.address.last_updated_by = current_user.id
    end

    def set_household
      @household = Household.find_by(id: params[:id])
    end

    # The following requires certain parameters be sent when making requests
    # to this controller. Nested models must have "_attributes" appended to
    # the model name in the "permit" as well as the payload to the controller.
    def household_params
      params.require(:household).permit(:number, :name,
                                        address_attributes: %i[id line_1
                                                               line_2
                                                               city
                                                               state
                                                               zip_code
                                                               zip_4
                                                               _destroy])
    end
  end
end
