
   # lib/my_project.rb
   # require_relative "my_project/version"

module MyProject
    class Main
        def self.run
        p ARGV[1]
        puts "Hello, MyProject!"
        end
    end
end
   
