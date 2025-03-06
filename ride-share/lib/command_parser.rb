require_relative '../config/config'
module CommandParser
  class << self
    include Config
    def parse(input)
      tokens = tokenize(input)
      action = _action_parser(tokens)
      params = _params_parser(tokens, action)
      {action: , params: }
    end

    private

    def _params_parser(tokens, action)
      params = {}
      params_config = PARAMS_PARSER_CONFIG[action]
      params_config.keys.each{|param_key|
        param_config = params_config[param_key]
        params[param_key] = _param_parser(tokens, param_config)
      }
      params
    end

    def _param_parser(tokens, param_config)
      index = param_config[:index]
      type = param_config[:type]
      TYPE_CAST[type].call(tokens[index])
    end

    def _action_parser(tokens)
      input_action = tokens[ACTION_INDEX]
      parsed_action = ACTION_PARSER_CONFIG[input_action]
      raise ArgumentError.new("Invalid command for #{input_action}") if parsed_action.nil? 
      parsed_action  
    end
  
    def tokenize(input)
      tokens = input.split(' ').map{ |token| token.strip }
      tokens.select{ |token| !token.empty? }
    end
  end
end