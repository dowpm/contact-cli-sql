require_relative 'config/environment'

task :console do
    Pry.start
end

def reload!
    load 'lib/contact.rb'
end

def clear
    system 'clear' or system 'cls'
end