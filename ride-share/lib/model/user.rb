require 'db/database'

class User
  include Database

  attr_reader :id, :location
  attr_writer :location
  def initialize(attrs)
    @id = attrs[:id]
    @location = attrs[:location]
    self.post_initialize
  end

  private
  def post_initialize
    nil
  end
end