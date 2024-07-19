# app/operations/bookings/destroy_booking.rb
module Bookings
    class DestroyBooking
      def initialize(booking)
        @booking = booking
      end
  
      def call
        if @booking.destroy 
          Result.new(success: true , message: 'Reservation was successfully deleted.')
        else
          Result.new(success: false, message: 'Failed to delete the reservation.')
        end
      end
    end
  end
  