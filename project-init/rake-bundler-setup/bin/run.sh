
   #!/bin/bash

   bundle install
   ruby -Ilib -r my_project -e MyProject::Main.run argument

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
   #   export $(grep -v ^# .env | xargs)
   # fi

   # # Start the application
   # echo "🛠 Running the application..."
   # bundle exec ruby my_project.rb  # Replace with your actual entry file

   # echo "✅ Application exited successfully!"
   
