require_relative './user'
class Rider < User
  attr_accessor :matches
  def post_initialize
    @matches = nil
  end
end