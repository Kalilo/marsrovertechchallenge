require 'read_file_input'
require 'map'

class Program
  attr_accessor :options
  attr_reader :map

  def initialize(options)
    @options = options
  end

  def main
    run_file
  end

  # def run_interactive
  # end

  # def add_rover
  #   loop do
  #     print 'Enter rover position (x y direction): '
  #   end
  # end

  # def get_map_size
  #   loop do
  #     print 'Enter map size (x y): '
  #     mapsize = gets.chomp.split(' ').map { |k| k.to_i } rescue { puts 'invalid mapsize provided' && next }
  #     return mapsize
  #   end
  # end

  def run_file(file = @options[:file])
    load_file
    print_map('Starting Map:') if @options[:map] || @options[:verbose]
    run
    print_map('Final Map:') if @options[:map] || @options[:verbose]
    @map.rovers.each { |rover| puts rover.position.get_display_pos }
  end

  def run
    @map.rovers.each do |rover|
      loop do
        break unless rover.has_next_command?
        begin
          puts "running #{rover.commands.first} on rover #{rover}" if @options[:verbose]
          map.execute_rover_command(rover)
          print_map if @options[:verbose] && !last_command?(rover)
        rescue => exception
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
    !rover.has_next_command? && @map.rovers.last == rover
  end

  def load_file(file = @options[:file])
    load_map(ReadFileInput.new(file).read_file)
  end

  def load_map(map_data)
    @map = Map.new(map_data[:size][0] + 1, map_data[:size][1] + 1)
    map_data[:rovers].each { |rover| @map.add_rover(rover) }
  end
end
