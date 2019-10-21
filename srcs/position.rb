# frozen_string_literal: true

class Position
  attr_reader :x, :y, :direction

  VALID_DIRECTIONS = %w[N S E W].freeze

  def initialize(x_coord, y_coord, direction)
    validate_coordinate(x_coord)
    validate_coordinate(y_coord)
    validate_direction(direction)
    @x = x_coord
    @y = y_coord
    @direction = direction
  end

  def move(units = 1)
    case @direction
    when 'N'
      Position.new(x, y + units, direction)
    when 'E'
      Position.new(x + units, y, direction)
    when 'S'
      Position.new(x, y - units, direction)
    when 'W'
      Position.new(x - units, y, direction)
    end
  end

  def turn_left
    case @direction
    when 'N'
      Position.new(x, y, 'W')
    when 'E'
      Position.new(x, y, 'N')
    when 'S'
      Position.new(x, y, 'E')
    when 'W'
      Position.new(x, y, 'S')
    end
  end

  def turn_right
    case @direction
    when 'N'
      Position.new(x, y, 'E')
    when 'E'
      Position.new(x, y, 'S')
    when 'S'
      Position.new(x, y, 'W')
    when 'W'
      Position.new(x, y, 'N')
    end
  end

  def direction_arrow
    case @direction
    when 'N'
      '↑'
    when 'E'
      '→'
    when 'S'
      '↓'
    when 'W'
      '←'
    end
  end

  def same_coords?(other)
    @x == other.x && @y == other.y
  end

  def ==(other)
    @x == other.x && @y == other.y && @direction == other.direction
  end

  def self.rand_position(direction = rand_direction, max = 100, min = 0)
    Position.new(rand_coord(min, max), rand_coord(min, max), direction)
  end

  def self.rand_direction
    VALID_DIRECTIONS.sample
  end

  def display_pos
    "#{@x} #{@y} #{@direction}"
  end

  def to_s
    "(#{@x}, #{@y}; #{@direction})"
  end

  def inspect
    to_s
  end

  private

  def self.rand_coord(min, max)
    rand(min..max)
  end

  def validate_coordinate(coordinate_value)
    raise "invalid coordinate: #{coordinate_value}" unless coordinate_value.is_a?(Integer)
  end

  def validate_direction(direction)
    raise "invalid direction: #{direction}" unless VALID_DIRECTIONS.include?(direction)
  end
end
