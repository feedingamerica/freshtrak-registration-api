# frozen_string_literal: true

module Api
  # Exposes the Families data
  class FamiliesController < Api::BaseController
    # POST api/family
    def create
      @family = Family.new
      if @family.save
        render json: @family
      else
        render json: @family.errors, status: :unprocessable_entity
      end
    end
  end
end
