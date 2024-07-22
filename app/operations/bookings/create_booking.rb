module Bookings
  class CreateBooking
    def initialize(user, bus, seat_ids, date)
      @user = user
      @bus = bus
      @seat_ids = seat_ids
      @date = date
    end

    def call
      existing_bookings = @bus.bookings.where(seat_id: @seat_ids, booking_date: @date)
      

      if existing_bookings.present?
        Result.new(success: false, message: "seats are already booked for the selected date.")
      elsif @seat_ids == nil
        Result.new(success: false, message: "select some seats")
      else
        @seat_ids.each do |seat_id|
          Booking.create(user: @user, seat_id: seat_id, booking_date: @date, bus: @bus)
          # debugger
          PaymentMailer.payment_confirmation(@user,Booking.last).deliver_now
        end
        Result.new(success: true, message: "Booking successful!")
      end
    end
  end
end


