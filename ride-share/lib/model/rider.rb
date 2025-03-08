require 'model/user'

class Rider < User
  attr_accessor :matches
  def post_initialize
    @matches = nil
    @riding = false
  end

  def riding?
    self.riding
  end

  def stop_riding
    self.riding = false
  end
  

  def start_riding
    self.riding = true
  end
  private 

  attr_accessor :riding
end