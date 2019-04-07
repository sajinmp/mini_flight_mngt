module Concerns
  module FlightConcerns
    def create_pnrs
      seat_configs = airline.seat_configs
      pnrs = Array.new
      seat_configs.each do |seat_config|
        (seat_config.no_of_rows * seat_config.seats_in_row).times { pnrs << {flight_id: self.id, seat_config_id: seat_config.id} }
      end
      Pnr.import(pnrs)
    end
  end
end
