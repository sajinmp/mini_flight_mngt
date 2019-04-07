class BookingsController < ApplicationController
  include Concerns::BookingConcerns
  def index
  end

  def new
    @pnr = Pnr.find(params[:pnr])
    @flight = @pnr.flight
    @seat_configs = @flight.seat_configs.includes(:seat_type_config)
    @booking = Booking.new
  end

  def create
    create_booking(params)
  end

  def show
    @booking = Booking.find(params[:id])
    @flight = @booking.flight
  end
end
