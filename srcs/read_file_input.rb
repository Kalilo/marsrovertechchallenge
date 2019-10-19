require 'rover'
require 'position'
require 'command'

class ReadFileInput
  attr_accessor :file_name

  def initialize(file_name = nil)
    @file_name = file_name
  end

  def read_file
    file = {}
    open_file
    file[:size] = read_map_size
    file[:rovers] = read_rovers
    close_file
    file
  end

  def open_file
    @file = File.open @file_name, 'r'
  end

  def close_file
    @file.close
  end

  def eof?
    @file.eof?
  end

  def read_map_size
    size = @file.readline.chomp.split(' ').map { |k| k.to_i } rescue invalid_input_file
    invalid_input_file if size.size != 2
    size
  end

  def read_rovers
    rovers = []
    loop do
      break if eof?
      rovers.push(Rover.new(read_position, read_commands))
    end
    rovers
  end

  def read_position
    pos_arr = @file.readline.chomp.split(' ')
    invalid_input_file if pos_arr.size != 3
    pos = Position.new(pos_arr[0].to_i, pos_arr[1].to_i, pos_arr[2])
  end

  def read_commands
    c_arr = @file.readline.chomp.split('')
    commands = c_arr.map { |c| Command.new(c) }
  end

  private

  def invalid_input_file
    raise 'invalid input file'
  end
  
end