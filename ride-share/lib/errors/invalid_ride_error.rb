class InvalidRideError < StandardError
  attr_reader :code
  def initialize(message= 'ride not found')
    @code = 'INVALID_RIDE'
    super(message)
  end
end