module Concerns
  module BookingConcerns
    def create_booking(params)
      @pnr = Pnr.find(params[:booking][:pnr_id])
      @old_booking = Booking.find(params[:old_booking]) if params[:old_booking]
      if check_price(params[:booking][:amount], @old_booking&.amount)
        new_params = booking_params.except(:amount).merge!(flight_id: @pnr.flight_id, pnr_id: @pnr.id,
                              status: GlobalConfig.with_key('booked', 'booking_status'))
        new_params.merge!(amount: params[:booking][:amount].to_f + @old_booking&.amount.to_f)
        new_params.merge!(upgraded_booking_id: @old_booking.id, previous_amount: @old_booking.amount) if @old_booking
        booking = Booking.create!(new_params)
        @old_booking.update!(status: GlobalConfig.with_key('upgrade', 'booking_status')) if @old_booking
        flash[:success] = 'Seat booking success'
        redirect_to booking
      else
        flash[:error] = 'Amount mismatch. Please try again'
        return render :new
      end
    end

    def check_price(amount, old_amount = nil)
      @pnr.seat_config.base_price - old_amount.to_f == amount.to_f
    end

    def booking_params
      params.require(:booking).permit(:amount, :seat_no)
    end
  end
end
