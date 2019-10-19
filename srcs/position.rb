class Position
  attr_reader :x, :y, :direction

  VALID_DIRECTIONS = %W'N S E W'

  def initialize(x, y, direction)
    validate_coordinate(x)
    validate_coordinate(y)
    validate_direction(direction)
    @x = x
    @y = y
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

  def same_coords?(pos)
    @x == pos.x && @y == pos.y
  end

  def ==(pos)
    @x == pos.x && @y == pos.y && @direction == pos.direction
  end

  def self.rand_position(direction = rand_direction, max = 100, min = 0)
    Position.new(rand_coord(min, max), rand_coord(min, max), direction)
  end

  def self.rand_direction
    VALID_DIRECTIONS.sample
  end

  def get_display_pos
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
    raise "invalid coordinate: #{coordinate_value}" unless coordinate_value.is_a?(Integer) # && (coordinate_value >= 0)
  end

  def validate_direction(direction)
    raise "invalid direction: #{direction}" unless VALID_DIRECTIONS.include?(direction)
  end
end