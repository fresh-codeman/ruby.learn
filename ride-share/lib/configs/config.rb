module Config
  ACTION_INDEX = 0
  PARAMS_PARSER_CONFIG = {
    add_driver: {
      driver_id: { index: 1, type: :string},
      x_coordinate: { index: 2, type: :integer},
      y_coordinate: { index: 3, type: :integer},
    },
    add_rider: {
      rider_id: { index: 1, type: :string},
      x_coordinate: { index: 2, type: :integer},
      y_coordinate: { index: 3, type: :integer},
    },
    match_drivers_to_rider: {
      rider_id: { index: 1, type: :string}
    },
    start_ride: {
      ride_id:{index: 1, type: :string},
      selected_driver_index: {index: 2, type: :integer},
      rider_id: {index:3, type: :string}
    },
    stop_ride: {
      ride_id:{index: 1, type: :string},
      destination_x_coordinate: {index: 2, type: :integer},
      destination_y_coordinate: {index:3, type: :integer},
      time_taken_in_min: {index:4, type: :integer}
    },
    bill: {
      ride_id:{index: 1, type: :string},
    }
  }.freeze
  TYPE_CAST = {
    string: ->(value) { value.to_s },
    integer: ->(value) { value.to_i },
    float: ->(value) { value.to_f }
  }.freeze
  ACTION_PARSER_CONFIG = {
    'ADD_DRIVER' => :add_driver,
    'ADD_RIDER' => :add_rider,
    'MATCH' => :match_drivers_to_rider,
    'START_RIDE'=> :start_ride,
    'STOP_RIDE'=> :stop_ride,
    'BILL'=> :bill,
  }.freeze
end