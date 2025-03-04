# Bundler project setup

This [directory](/project-init/bundler-setup) has a example project that simple projects might need.

## Requirement to use this setup

ruby, bundler, internet connection

## folder structure

```
my_project/          # Root directory
│── bin/             # Executable scripts (like CLI entry points)
│   ├── console      # IRB console loader
│   ├── run.bat      # Custom setup scripts for windows it can be named as setup sometimes
│   ├── run.sh       # Custom setup scripts for linux/mac it can be named as setup sometimes
│
│── lib/             # Main Ruby code
│   ├── my_project/  # Namespace directory
│   │   ├── version.rb  # Version information
│   │   ├── my_class.rb  # Example class
│   │   ├── another_class.rb
│   ├── my_project.rb  # Main entry file requiring all classes
│
│── spec/            # RSpec tests (if using RSpec)
│   ├── lib/my_project/my_class_spec.rb
│   ├── another_class_spec.rb
│   ├── spec_helper.rb
│
│── Gemfile          # Gem dependencies
│── Gemfile.lock     # Lock file (auto-generated)
│── README.md        # Project documentation
│── .gitignore       # Ignore unnecessary files in Git
│── .rspec           # RSpec configuration (if using RSpec)
│── LICENSE          # Open-source license (if applicable)
```

## steps to create

1. initiate bundler that create empty gemfile which hold the all the dependencies

```
bundler init
```

2. add ruby testing framework rspec to gemfile

```
echo 'gem "rspec"'>>Gemfile
```

3. install all the dependencies

```
bundle install
```

it will create gemfile.lock that track all the dependencies of your dependencies. do not worry it is auto generated.

4. initiate the rspec

```
rspec --init
```

it will create spec/spec_helper.rb and .rspec file to start the testing.

5. create remaining folder structure

```
mkdir -p bin lib/my_project spec/lib/my_project
touch README.md .gitignore LICENSE bin/console bin/run.bat bin/run.sh lib/my_project.rb lib/my_project/my_class.rb spec/lib/my_project/my_class_spec.rb
```

6. Now update files by running following commands

   1. console will start launching the irb or pry after this

   ```sh
   echo '''
   #!/usr/bin/env ruby

   require "bundler/setup"  # Load gems from the Gemfile
   require_relative "../lib/my_project"  # Load your project

   # Use IRB or Pry (if installed)
   if Gem.loaded_specs.has_key?("pry")
   require "pry"
   Pry.start
   else
   require "irb"
   IRB.start
   end
   ''' >> bin/console
   ```

   2. run.bat build and start the application

   ```sh
   echo '''
   @echo off

   bundle install
   ruby -Ilib -r my_project -e 'MyProject::Main.run' argument
   ''' >> bin/run.bat
   ```

   3. run.sh build and start the application

   ```sh
   echo '''
   #!/bin/bash

   bundle install
   ruby -Ilib -r my_project -e 'MyProject::Main.run' argument

   # Example code for big project
   # set -e  # Exit immediately if any command fails

   # echo "🚀 Starting the application..."

   # # Ensure dependencies are installed
   # if ! command -v bundle >/dev/null; then
   #   echo "⚠️  Bundler is not installed. Installing now..."
   #   gem install bundler
   # fi

   # echo "📦 Installing gems..."
   # bundle install

   # # Load environment variables if an .env file exists
   # if [ -f ".env" ]; then
   #   echo "🌱 Loading environment variables..."
   #   export $(grep -v '^#' .env | xargs)
   # fi

   # # Start the application
   # echo "🛠 Running the application..."
   # bundle exec ruby my_project.rb  # Replace with your actual entry file

   # echo "✅ Application exited successfully!"
   ''' >> bin/run.sh
   ```

   4. now allow these files of permission of executable

   ```sh
   chmod +x bin/console
   chmod +x bin/run.sh
   ```

   now you can use 'bin/console' to start the console and 'bin/run.sh' to build and start the project.

   5. update lib/my_project.rb with following

   ```sh
   echo '''
   # lib/my_project.rb
   # require_relative "my_project/version"

   module MyProject
   class Main
       def self.run
       puts "Hello, MyProject!"
       end
   end
   end
   ''' >> lib/my_project.rb
   ```

   6. license

   ```sh
   echo '''
   MIT License

   Copyright (c) 2021 Wizzenalum

   Permission is hereby granted, free of charge, to any person obtaining a copy
   of this software and associated documentation files (the "Software"), to deal
   in the Software without restriction, including without limitation the rights
   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
   copies of the Software, and to permit persons to whom the Software is
   furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all
   copies or substantial portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
   SOFTWARE.
   ''' >> LICENSE
   ```

   7. .gitignore

   ```sh
echo '''
# Ignore bundler dependencies
/vendor/bundle

# Ignore log files
/log/*
!log/.keep  # Keep the folder but ignore its contents

# Ignore temporary files
/tmp/*
!tmp/.keep  # Keep the folder but ignore its contents

# Ignore RubyMine/VSCode/Editor settings
.idea/
.vscode/
*.swp
*.swo
*.sublime*

# Ignore OS-specific files
.DS_Store
Thumbs.db

# Ignore test coverage reports (SimpleCov)
coverage/

# Ignore RSpec-related files
/spec/tmp
/spec/examples.txt

# Ignore Git-related files
.git/
''' >> .gitignore
```

7. now execute following command to confirm is it running

```
bin/run.sh
```

8. I also added the example of the one class testing here.
