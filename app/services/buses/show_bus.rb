# app/services/buses/show_bus.rb
module Buses
    class ShowBus
      def initialize(bus_id)
        @bus_id = bus_id
      end
  
      def call
        Bus.find(@bus_id)
      end
    end
  end
  