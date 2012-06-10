#!/usr/bin/env ruby

require 'optparse'
require 'fileutils'

#require "#{Dir.pwd}/lib/builder/builder"
#require "#{Dir.pwd}/lib/templates/template"
#require "#{Dir.pwd}/lib/util/file"

require_relative "../lib/builder/builder"
require_relative "../lib/templates/template"
require_relative "../lib/util/file"

OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [path]"

  opts.on("-h", "--help", "Displays this help info") do
    puts opts
    exit 0
  end

  begin
    opts.parse!(ARGV)
  rescue OptionParser::ParseError => e
    warn e.message
    puts opts
    exit 1
  end
end

if ARGV.empty?
  abort "Please specify the directory to capify, e.g. `#{File.basename($0)} .'"
elsif !File.exists?(ARGV.first)
  abort "`#{ARGV.first}' does not exist."
elsif !File.directory?(ARGV.first)
  abort "`#{ARGV.first}' is not a directory."
elsif ARGV.length > 1
  abort "Too many arguments; please specify only the directory to kapify."
end

Kapy::File.new.write_or_update_files(Kapy::Builder.new.generate_deploy_file, ARGV.shift)
