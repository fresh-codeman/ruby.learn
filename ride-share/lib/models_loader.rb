
all_dir = Dir[File.join('model', '*.rb')]

all_dir.each { |file| require file }

