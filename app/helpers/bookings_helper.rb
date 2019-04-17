module BookingsHelper
  def get_flight_no(flight_id)
    Flight.encode_id(flight_id)
  end

  def get_booking_details(flight_booking)
    [flight_booking.flight, flight_booking&.seat_details[:seat_info]]
  end

  def seat_no(seat)
    seat['seat_no']
  end

  def seat_config(seat)
    seat['seat_config']
  end

  def seat_class(flight, seat)
    flight.seat_configs.find { |i| i.id == seat['seat_config'].to_i }&.seat_type_config&.config_key&.humanize
  end

  def upgrade_available(pnr)
    seat_config = pnr.seat_config
    seat_types = GlobalConfig.where(configurable_type: 'seat_types').map { |i| [i.config_key, i.value] }
    upgradable_config = seat_types.select { |i| i[1] < seat_config.seat_type }
    return false if upgradable_config.blank?
    flight = pnr.flight
    upgradable_pnr = Hash.new
    upgradable_config.each do |config|
      pnr = get_pnr_for_config(flight, config[1])
      upgradable_pnr[config[0]] = pnr if pnr
    end
    return false if upgradable_pnr.blank?
    return upgradable_pnr
  end

  def get_pnr_for_config(flight, seat_type)
    seat_config_for_seat_type = flight.seat_configs.find_by(seat_type: seat_type)
    booked_pnrs = flight.bookings.joins(pnr: :seat_config).where(status: GlobalConfig.with_key('booked', 'booking_status'),
                                                    seat_configs: { seat_type: seat_type }).map(&:pnr_id)
    all_pnrs = flight.pnrs.joins(:seat_config).where(seat_configs: {seat_type: seat_type}).map(&:id)
    available_pnrs = all_pnrs - booked_pnrs
    return false if available_pnrs.blank?
    return Pnr.encode_id(available_pnrs[0])
  end

  def check_seat_availability(pnr, seat_config, seat_number, booked_seats)
    booked_seat = booked_seats.include?(seat_number)
    [(@pnr.seat_config_id != seat_config.id) || booked_seat, booked_seat]
  end
end
