# frozen_string_literal: true

require 'read_file'
require 'map'

class Program
  attr_accessor :options
  attr_reader :map

  def initialize(options)
    @options = options
  end

  def run_file(_file = @options[:file])
    load_file
    print_map('Starting Map:') if @options[:map] || @options[:verbose]
    run
    print_map('Final Map:') if @options[:map] || @options[:verbose]
    @map.rovers.each { |rover| puts rover.position.display_pos }
  end

  def run
    @map.rovers.each do |rover|
      loop do
        break unless rover.next_command?

        begin
          puts "running #{rover.commands.first} on rover #{rover}" if @options[:verbose]
          map.execute_rover_command(rover)
          print_map if @options[:verbose] && !last_command?(rover)
        rescue StandardError => exception
          puts "error processing command: #{exception}"
        end
      end
    end
  end

  def print_map(message = nil)
    puts message if message
    puts @map
  end

  def last_command?(rover)
    !rover.next_command? && @map.rovers.last == rover
  end

  def load_file(file = @options[:file])
    load_map(ReadFile.new(file).read)
  end

  def load_map(map_data)
    @map = Map.new(map_data[:size][0] + 1, map_data[:size][1] + 1)
    map_data[:rovers].each { |rover| @map.add_rover(rover) }
  end
end
