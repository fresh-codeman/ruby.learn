require 'helper/load_models'

module BillController
  def self.bill(params)
    ride_id = params[:ride_id]
    ride = Ride.get(ride_id){|_ride| _ride.status == RideStatus::COMPLETED}
    raise InvalidRideError.new("Ride not exists/available for ride_id: #{ride_id}") unless ride
    driver_id = ride.driver.id
    amount = ride.amount.round(2)
    {data: {ride_id: , driver_id:, amount:},  error:nil}
  rescue => error
    {error: , data: nil}
  end
end