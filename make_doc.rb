#!/usr/bin/env ruby

puts "Creating documentation."
system "rdoc --title 'AnsiTerm::ANSIColor' --main README -d README #{Dir['lib/**/*.rb'] * ' '}"
