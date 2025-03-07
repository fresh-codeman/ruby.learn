require 'model/location'
require 'model/driver'
require 'model/rider'
require 'model/ride'

module MatchController
  PROXIMITY_RAGE = 5
  def self.match_drivers_to_rider(params)
    rider_id = params[:rider_id]
    rider = Rider.get(rider_id){ |_rider| !_rider.riding? }
    raise NoDriverAvailableError.new("Invalid rider id : #{rider_id}") unless rider
    from_location = rider.location
    drivers = Driver.get{ |_driver|  _driver.location.distance(from_location) <= PROXIMITY_RAGE}
    raise NoDriverAvailableError.new("No drivers Available for rider_id : #{rider_id}") if drivers.empty?
    drivers = drivers.sort_by{|a| [a.location.distance(from_location), a.id] }
    drivers = drivers[...5]
    rider.matches = drivers
    rider.save
    driver_ids = drivers.map{|driver| driver.id}
    {driver_ids: }
  end
end

class NoDriverAvailableError < StandardError
  attr_reader :code
  def initialize(message = 'no driver available')
    @code = 'NO_DRIVERS_AVAILABLE'
    super(message)
  end
end

class Gerror
  attr_reader :status
  def initialize
    @status = status
  end
end