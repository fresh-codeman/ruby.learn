module View
  class << self
    def add_driver(data)
      nil
    end

    def add_rider(data)
      nil
    end

    def match_drivers_to_rider(data)
      driver_ids = data[:driver_ids]
      message = "DRIVERS_MATCHED #{driver_ids.join(' ')}"
      puts message
    rescue StandardError => error
      message = error.respond_to?(:code) ? error.code : error.message
      puts message
      message
    end

    def start_ride(data)
      ride_id = data[:ride_id]
      message = "RIDE_STARTED #{ride_id}"
      puts message
    rescue => error
      message = error.respond_to?(:code) ? error.code : error.message
      puts message
      message
    end

    def stop_ride(data)
      ride_id = data[:ride_id]
      message = "RIDE_STOPPED #{ride_id}"
      puts message
    rescue => error
      message = error.respond_to?(:code) ? error.code : error.message
      puts message
      message
    end

    def bill(data)
      ride_id, driver_id, amount = data.values_at(:ride_id, :driver_id, :amount)
      message = "BILL #{[ride_id, driver_id, amount].join(' ')}"
      puts message
    rescue => error
      message = error.respond_to?(:code) ? error.code : error.message
      puts message
      message
    end
  end
end