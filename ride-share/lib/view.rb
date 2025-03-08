module View
  class << self
    def add_driver(result_wrapper)
      error = result_wrapper[:error]
      handle_error(error)
    end

    def add_rider(result_wrapper)
      error = result_wrapper[:error]
      handle_error(error)
    end

    def match_drivers_to_rider(result_wrapper)
      data, error = result_wrapper.values_at(:data, :error)
      handle_error(error)
      return unless data

      driver_ids = data[:driver_ids]
      message = "DRIVERS_MATCHED #{driver_ids.join(' ')}"
      puts message
    end

    def start_ride(result_wrapper)
      data, error = result_wrapper.values_at(:data, :error)
      handle_error(error)
      return unless data

      ride_id = data[:ride_id]
      message = "RIDE_STARTED #{ride_id}"
      puts message
    end

    def stop_ride(result_wrapper)
      data, error = result_wrapper.values_at(:data, :error)
      handle_error(error)
      return unless data

      ride_id = data[:ride_id]
      message = "RIDE_STOPPED #{ride_id}"
      puts message
    end

    def bill(result_wrapper)
      data, error = result_wrapper.values_at(:data, :error)
      handle_error(error)
      return unless data

      ride_id, driver_id, amount = data.values_at(:ride_id, :driver_id, :amount)
      message = "BILL #{[ride_id, driver_id, amount].join(' ')}"
      puts message
    end

    private

    def handle_error(error)
      return unless error
      message = error.message
      message = error.code if error.respond_to?(:code)
      puts message
    end
  end
end