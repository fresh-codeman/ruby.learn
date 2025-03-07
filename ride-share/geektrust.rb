# Add a custom directory to $LOAD_PATH
$LOAD_PATH.unshift(File.expand_path('lib', __dir__))
require 'command_parser'
require 'command_executor'
def main
  File.open(ARGV[1]) do |file|
    file.readlines.each do |line|
     parsed_command = CommandParser.parse(line)
     CommandExecutor.execute(parsed_command)
    rescue => error
      message = error.respond_to?(:code) ? error.code : error.message
      puts message
      message
    end
  end
end
