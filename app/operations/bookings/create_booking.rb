# app/operations/bookings/create_booking.rb
module Bookings
    class CreateBooking
      def initialize(user, bus, seat_ids, date)
        @user = user
        @bus = bus
        @seat_ids = seat_ids
        @date = date
      end
  
      def call
        return Result.new(success: false, message: "Please select at least one seat and provide a valid date.") if @date.blank? || @seat_ids.blank?
  
        ActiveRecord::Base.transaction do
          @seat_ids.each do |seat_id|
            Booking.create!(user: @user, seat_id: seat_id, booking_date: @date, bus: @bus)
          end
        end
        Result.new(success: true, message: "Seats successfully booked for #{@date}")
      rescue ActiveRecord::RecordInvalid => e
        Result.new(success: false, message: e.message)
      end
    end
  end
  