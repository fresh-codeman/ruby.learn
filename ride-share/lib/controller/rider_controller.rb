require 'models_loader'

module RiderController

  def self.add_rider(params)
    x_coordinate, y_coordinate, rider_id = params.values_at(:x_coordinate, :y_coordinate, :rider_id)
    location = Location.new({x_coordinate:, y_coordinate:})
    rider_attrs = {location: location, id: rider_id}
    rider = Rider.new(rider_attrs)
    rider.save
  end
end