# frozen_string_literal: true

require 'rover'

class Map
  attr_reader :height, :width, :map, :rovers

  def initialize(width, height)
    validate_size(height)
    validate_size(width)
    @height = height
    @width = width

    @map = Array.new(width) { Array.new(height) }
    @rovers = []
  end

  def add_rover(rover)
    pos = rover.position
    validate_position(pos)
    @map[pos.x][pos.y] = rover
    @rovers.push(rover)
  end

  def to_s
    str = ''
    div = ('-' * (width * 4 + 1)) + "\n"

    height.times.reverse_each do |y|
      str += div
      width.times do |x|
        e = @map[x][y]
        str += if e.is_a? Rover
                 "|R #{e.position.direction_arrow}"
               elsif e.nil?
                 '|   '
               else
                 '| ? '
               end
      end
      str += "|\n"
    end
    str += div

    str
  end

  def inspect
    "\n" + to_s
  end

  def execute_rover_command(rover, command = nil)
    pos = rover.position
    new_pos = rover.execute_command(command)

    unless pos.same_coords?(new_pos)
      validate_position(new_pos)
      @map[pos.x][pos.y] = nil
      @map[new_pos.x][new_pos.y] = rover
    end

    rover.position = new_pos
  end

  private

  def validate_size(size)
    raise "invalid map size: #{size}" unless size.is_a?(Integer) && size > 1
  end

  def validate_position(pos)
    raise "not a position: #{pos}" unless pos.is_a? Position
    raise "position #{pos} out of bounds" unless (pos.x >= 0 && pos.x < @width) && (pos.y >= 0 && pos.y < @height)
    raise "attempting to add element ontop of exising element at position: #{pos}" unless @map[pos.x][pos.y].nil?
  end
end
