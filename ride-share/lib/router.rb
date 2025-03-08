require 'helper/load_controllers'
require_relative './view'
module Router
  ROUTER = {
            add_driver: { controller: DriverController, view: View },
            add_rider: { controller: RiderController, view: View },
            match_drivers_to_rider: { controller: MatchController, view: View },
            start_ride: { controller: RideController, view: View },
            stop_ride: { controller: RideController, view: View },
            bill: { controller: BillController, view: View }
          }.freeze
end 