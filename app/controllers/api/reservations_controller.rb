class Api::ReservationsController < Api::BaseController
  before_action :set_reservation, only: [:show, :delete]

  # GET /api/reservations
  def index
    @reservations = reservation.where(user_id: current_user.id)

    render json: @reservations
  end

  # GET /api/reservations/1
  def show
    render json: @reservation
  end

  # POST /api/reservations
  def create
    result = CreateReservation.new(
      user_id: reservation_params[:user_id],
      event_date_id: reservation_params[:event_date_id]
    ).call
    @reservation = result.reservation

    if result.success?
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/reservations/1
  def delete
    @reservation.destroy
    render json: {deleted: true}
  end

  private
    def set_reservation
      @reservation = Reservation.find_by(
        id: params[:id], user_id: current_user.id
      )
    end

    # Only allow a trusted parameter "white list" through.
    def reservation_params
      params.require(:reservation)
        .permit(:event_date_id).merge(user_id: current_user.id)
    end
end
