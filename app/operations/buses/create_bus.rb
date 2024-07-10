# app/operations/buses/create_bus.rb
module Buses
    class CreateBus
      def initialize(user, bus_params)
        @user = user
        @bus_params = bus_params
      end
  
      def call
        @bus = @user.buses.new(@bus_params)
        
        if @bus.save
          Result.new(success: true, message: 'Bus was successfully created.')
        else
          Result.new(success: false, message: @bus)
          
        end
      end
    end
  end
  