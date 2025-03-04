
   @echo off

   bundle install
   ruby -Ilib -r my_project -e MyProject::Main.run argument
   
