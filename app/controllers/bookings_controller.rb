class BookingsController < ApplicationController
  include Concerns::BookingConcerns
  def index
  end

  def new
    @pnr = Pnr.find(params[:pnr])
    if @pnr.confirmed_booking
      flash[:error] = 'PNR already booked'
      redirect_to root_path
    end
    @flight = @pnr.flight
    @seat_configs = @flight.seat_configs.includes(:seat_type_config)
    @booked_seats = @flight.bookings.joins(pnr: :seat_config).where(status: GlobalConfig.with_key('booked', 'booking_status'),
                                                seat_configs: { seat_type: @pnr.seat_config.seat_type }).map(&:seat_no)
    @booking = Booking.new
    @old_booking = Booking.find(params[:old_booking]) if params[:old_booking]
  end

  def create
    create_booking(params)
  end

  def show
    @booking = Booking.find(params[:id])
    @pnr = @booking.pnr
    @flight = @booking.flight
    respond_to do |format|
      format.html
      format.json { render json: {amount: @booking.amount} }
    end
  end
end
