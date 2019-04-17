module Concerns
  module BookingConcerns
    def list_flights(params)
      @origin, @destination, @no_of_seats = params[:origin], params[:destination], params[:no_of_seats]
      @direct_flights = Flight.flights_with_origin_destination(@origin, @destination)
      @connected_flights = Flight.join_flights.connected_flights(@origin, @destination).select_connected_flight_details
    end

    def create_booking(params)
      @booking = Booking.create!(booking_params)
      @seat_info = params[:seat_nos]
      flight_booking_details = []
      JSON.parse(params[:seat_nos]).each do |flight_id, seat_details|
        FlightBooking.create!(booking_id: @booking.id, flight_id: flight_id, seat_details: {seat_info: seat_details})
      end
      redirect_to passenger_bookings_path(@booking)
    end

    def confirm_booking(params)
      @booking = Booking.find(params[:id])
      passenger_info = []
      JSON.parse(params[:passenger_info]).each do |flight_id, seat_details|
        seat_details.each do |seat_info|
          passenger_info << {flight_id: flight_id, booking_id: @booking.id, seat_no: seat_info['seat_no'],
                             name: seat_info['name'], seat_config_id: seat_info['seat_config']}
        end
      end
      PassengerDetail.import(passenger_info)
      pnr = Pnr.create!(booking_id: @booking.id)
      @booking.update!(status: GlobalConfig.with_key('booked', 'booking_status'))
      flash[:success] = 'Booking successful'
      redirect_to @booking
    end

    def booking_params
      params.require(:booking).permit(:amount, :no_of_seats, :origin, :destination)
    end
  end
end
