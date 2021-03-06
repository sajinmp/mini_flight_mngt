class BookingsController < ApplicationController
  include Concerns::BookingConcerns

  def index
  end

  def list
    list_flights(params)
  end

  def search
    begin
      pnr = Pnr.find(params[:pnr])
      redirect_to pnr.booking
    rescue ActiveRecord::RecordNotFound
      flash[:error] = 'Invalid Pnr'
      redirect_to bookings_path
    end
  end

  def new
    @flights = Flight.includes(seat_configs: :seat_type_config).where(id: params[:flight_ids])
    @booked_seats = get_booked_seats(params[:flight_ids])
    @origin, @destination, @no_of_seats = params[:origin], params[:destination], params[:no_of_seats]
    @connected = params[:flight_ids].size > 1
    @booking = Booking.new
  end

  def create
    create_booking(params)
  end

  def passenger
    @booking = Booking.includes(flight_bookings: [flight: {seat_configs: :seat_type_config}]).find(params[:id])
  end

  def confirm
    confirm_booking(params)
  end

  # def new
  #   @flight = @pnr.flight
  #   @seat_configs = @flight.seat_configs.includes(:seat_type_config)
  #   @booked_seats = @flight.bookings.joins(pnr: :seat_config).where(status: GlobalConfig.with_key('booked', 'booking_status'),
  #                                               seat_configs: { seat_type: @pnr.seat_config.seat_type }).map(&:seat_no)
  #   @booking = Booking.new
  #   @old_booking = Booking.find(params[:old_booking]) if params[:old_booking]
  # end

  # def create
  #   create_booking(params)
  # end

  def show
    @booking = Booking.includes(passenger_details: {seat_config: :seat_type_config}, flight_bookings: :flight).find(params[:id])
    @pnr = @booking.pnr
  end
end
