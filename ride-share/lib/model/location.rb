class Location
  attr_reader :x_coordinate, :y_coordinate
  def initialize(attr = {})
    @x_coordinate = _coordinate_parser(attr[:x_coordinate])
    @y_coordinate = _coordinate_parser(attr[:y_coordinate])
  end

  def distance(location)
    x_difference_square = (self.x_coordinate - location.x_coordinate) ** 2
    y_difference_square = (self.y_coordinate - location.y_coordinate) ** 2
    Math.sqrt(x_difference_square + y_difference_square)
  end
  
  private

  def _coordinate_parser(coordinate)
    Float(coordinate)
  rescue
    raise ArgumentError.new('Invalid Argument for Location')
  end
end