require 'model/user'
class Driver < User
  def post_initialize
    @driving = false
  end

  def driving?
    self.driving
  end

  def stop_driving
    self.driving = false
  end
  

  def start_driving
    self.driving = true
  end
  private 

  attr_accessor :driving
end