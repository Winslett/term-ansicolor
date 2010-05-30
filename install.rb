#!/usr/bin/env ruby

require 'rbconfig'
include Config
require 'fileutils'
include FileUtils::Verbose

destdir = "#{ENV['DESTDIR']}"
libdir = CONFIG["sitelibdir"]
dest = destdir + File.join(libdir, 'ansiterm')
mkdir_p dest
install 'lib/ansiterm/ansicolor.rb', dest
dest = destdir + File.join(libdir, 'ansiterm', 'ansicolor')
mkdir_p dest
install 'lib/ansiterm/ansicolor/version.rb', dest
