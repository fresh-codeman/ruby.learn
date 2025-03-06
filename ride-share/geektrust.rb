$LOAD_PATH.unshift File.join(__dir__, 'lib')
require_relative './lib/command_parser'
def main
  File.open(ARGV[1]) do |file|
    file.readlines.each do |line|
     parsed_command = CommandParser.parse(line)
     p parsed_command
    #  response = Controller.execute(parsed_command[:action], parsed_command[:params])
    #  View(response)
    end
  end
end
