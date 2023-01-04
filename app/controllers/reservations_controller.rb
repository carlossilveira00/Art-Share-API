class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.includes(:item).where(["user_id = ? AND status = ?", params[:user_id], 'Accepted'])
    @current_reservations = []

    @reservations.each do |reservation|
      @current_reservations << {
        id: reservation.id,
        item_name: reservation.item.name,
        starting_date: reservation.starting_date,
        ending_date: reservation.ending_date,
        status: reservation.status,
        total_value: reservation.total_value
      }
    end

    render json: ReservationBlueprint.render(@current_reservations)
  end

  def handle_request
    @reservation = Reservation.find(params[:id])

    @reservation.update!(status: params[:status])

    render json: @reservation
  end

  def renting_requests
    @reservations = Reservation.includes(:item).where(items: { user_id: 3 }).where(status: 'Pending')
    @requests = []

    @reservations.each do |reservation|
      @requests << {
        id: reservation.id,
        item_name: reservation.item.name,
        starting_date: reservation.starting_date,
        ending_date: reservation.ending_date,
        status: reservation.status,
        total_value: reservation.total_value
      }
    end

    render json: ReservationBlueprint.render(@requests)
  end

  def completed_reservations
    @reservations = Reservation.includes(:item).where(["user_id = ? AND status = ?", 3, 'Completed'])
    @completed_reservations = []

    @reservations.each do |reservation|
      @completed_reservations << {
        id: reservation.id,
        item_name: reservation.item.name,
        starting_date: reservation.starting_date,
        ending_date: reservation.ending_date,
        status: reservation.status,
        total_value: reservation.total_value
      }
    end

    render json: ReservationBlueprint.render(@completed_reservations)
  end

  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save
      render json: @reservation
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
