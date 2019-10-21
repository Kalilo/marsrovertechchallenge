# frozen_string_literal: true

require 'optparse'

@options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: ruby #{$PROGRAM_NAME} -f <input_file>"

  opts.on('-h', '--help', 'Prints this help') do
    puts opts
    exit
  end

  opts.on('-fFILENAME', '--file=FILENAME', 'Set the file name') do |f|
    @options[:file] = f
  end

  opts.on('-v', '--[no-]verbose', 'Run verbosely') do |v|
    @options[:verbose] = v
  end

  opts.on('-m', '--[no-]map', 'Print map at begining and end') do |m|
    @options[:map] = m
  end
end.parse!

abort 'please privide input file' unless @options[:file]

p @options if @options[:verbose]
