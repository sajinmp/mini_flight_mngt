module Concerns
  module BookingConcerns
    def create_booking(params)
      @pnr = Pnr.find(params[:booking][:pnr_id])
      if check_price(params[:booking][:amount])
        booking = Booking.create!(booking_params.merge(flight_id: @pnr.flight_id, pnr_id: @pnr.id, status: 1))
        flash[:success] = 'Seat booking success'
        redirect_to booking
      else
        flash[:error] = 'Amount mismatch. Please try again'
        return render :new
      end
    end

    def check_price(amount)
      @pnr.seat_config.base_price == amount.to_f
    end

    def booking_params
      params.require(:booking).permit(:amount, :seat_no)
    end
  end
end
