require 'router'
module CommandExecutor
  include Router
  def self.execute(command)
    action, params = command.values_at(:action, :params)
    data = ROUTER[action][:controller].send(action, params)
    ROUTER[action][:view].send(action,data)
  end
end