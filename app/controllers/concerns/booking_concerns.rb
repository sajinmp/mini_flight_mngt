module Concerns
  module BookingConcerns
    def list_flights(params)
      @origin, @destination, @no_of_seats = params[:origin], params[:destination], params[:no_of_seats]
      @direct_flights = Flight.flights_with_origin_destination(@origin, @destination)
      @direct_flights = check_seat_availability(@direct_flights, @no_of_seats)
      @connected_flights = Flight.join_flights.connected_flights(@origin, @destination).select_connected_flight_details
      @connected_flights = check_seat_availability(@connected_flights, @no_of_seats, true)
    end

    def check_seat_availability(flights, seats, connected = nil)
      return check_seat_in_direct_flights(flights, seats) unless connected
      check_seat_in_connected_flights(flights, seats)
    end

    def check_seat_in_connected_flights(flights, seats)
      flight_ids = Array.new << flights.ids << flights.map(&:connection_id)
      impossible_flight_ids = get_seat_counts(flight_ids.flatten, seats)
      return flights if impossible_flight_ids.blank?
      flights.where('flights.id not in (?) and b.id not in (?)', impossible_flight_ids, impossible_flight_ids)
    end

    def check_seat_in_direct_flights(flights, seats)
      impossible_flight_ids = get_seat_counts(flights.ids, seats)
      flights.where.not(id: impossible_flight_ids)
    end

    def get_seat_counts(flight_ids, seats)
      booked_count = Hash[Booking.joins(:passenger_details).where(status: GlobalConfig.with_key('booked', 'booking_status'),
          passenger_details: {flight_id: flight_ids}).select('passenger_details.flight_id as flight_id,
          count(passenger_details.id) as booked_seats').group('passenger_details.flight_id')
          .map { |i| [i.flight_id, i.booked_seats] }]
      max_count = Flight.joins(:seat_configs).where(id: flight_ids).select('flights.id as id, sum(seat_configs.no_of_rows*seat_configs.seats_in_row) as max_seats').group('flights.id').map { |i| [i.id, i.max_seats] }
      remaining_seats = {}
      max_count.each do |flight_id, max_seats|
        remaining_seats[flight_id] = max_seats - booked_count[flight_id].to_i
      end
      impossible_flight_ids = remaining_seats.collect { |k, v| k if v < seats.to_i }.compact
      impossible_flight_ids
    end

    def create_booking(params)
      @booking = Booking.create!(booking_params)
      @seat_info = params[:seat_nos]
      flight_booking_details = []
      JSON.parse(params[:seat_nos]).each do |flight_id, seat_details|
        FlightBooking.create!(booking_id: @booking.id, flight_id: flight_id, seat_details: {seat_info: seat_details})
      end
      redirect_to passenger_booking_path(@booking)
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

    def get_booked_seats(flight_ids)
      booked = {}
      booked_status = GlobalConfig.with_key('booked', 'booking_status') 
      flight_ids.each do |id|
        booked[id.to_i] = PassengerDetail.joins(:booking).where(flight_id: id,
                                    bookings: { status: booked_status }).map { |i| [i.seat_no, i.seat_config_id] }
      end
      booked
    end
  end
end
