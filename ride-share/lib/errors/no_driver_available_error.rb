class NoDriverAvailableError < StandardError
  attr_reader :code
  def initialize(message = 'no driver available')
    @code = 'NO_DRIVERS_AVAILABLE'
    super(message)
  end
end