# app/services/buses/new_bus.rb
module Buses
    class NewBus
      def initialize(user)
        @user = user
      end
  
      def call
        Bus.new(user: @user)
      end
    end
  end
  