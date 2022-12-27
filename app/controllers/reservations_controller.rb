class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.all

    render json: ReservationBlueprint.render(@reservations)
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: ReservationBlueprint.render(@reservation)
    else
      render json: {
        message: 'Could not book this item.',
        status: :unauthorized
      }
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])

    if @reservation.destroy
      render json: {
        message: 'This Reservation was canceled.'
      }, status: :ok
    else
      render json: {
        error: @item.errors.messages
      }, status: :unauthorized
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:item_id, :starting_date, :ending_date, :user_id, :status, :total_value)
  end
end
