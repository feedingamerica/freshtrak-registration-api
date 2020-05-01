class Api::UsersController < Api::BaseController
  # GET /api/user
  def show
    render json: current_user
  end

  # PATCH/PUT /api/user
  def update
    if current_user.update(api_user_params)
      render json: current_user
    else
      render json: current_user.errors, status: :unprocessable_entity
    end
  end

  private

  # Only allow a trusted parameter "white list" through.
  def api_user_params
    params.fetch(:api_user, {})
  end
end
