require 'minitest/autorun'
require 'position'

class PositionTest < Minitest::Test
  def test_invalid_directions
    invalid_directions = (('A'..'Z').map { |l| l  } - Position::VALID_DIRECTIONS) + [1, nil, 'West']

    invalid_directions.each do |d|
      assert_raises { Position.new(rand_coord, rand_coord, d) }
    end
  end

  def test_valid_directions
    Position::VALID_DIRECTIONS.each do |d|
      assert_kind_of Position, Position.new(rand_coord, rand_coord, d)
    end
  end

  def test_invalid_coodinates
    invalid_coords = [0.1, 'Six', nil, [0, 1]]

    invalid_coords.each do |c|
      assert_raises { Position.new(c, c, Position.rand_direction) }
    end
  end

  def test_valid_coodinates
    10.times do
      assert_kind_of Position, Position.rand_position
    end
  end

  def test_mutability
    p = Position.rand_position

    assert p != p.move
    assert p != p.turn_left
    assert p != p.turn_right
  end

  def test_rand
    5.times do
      assert_kind_of Position, Position.rand_position
      assert_kind_of Position, Position.rand_position(Position.rand_direction)
    end
  end

  def test_same_coords
    assert Position.new(0, 0, 'N').same_coords?(Position.new(0, 0, 'S'))
    assert Position.new(6, 2, 'W').same_coords?(Position.new(6, 2, 'N'))
    assert !(Position.new(6, 3, 'W').same_coords?(Position.new(6, 2, 'W')))
    assert !(Position.new(7, 2, 'W').same_coords?(Position.new(6, 2, 'S')))
  end

  def test_direction_arrows
    assert Position.rand_position('N').direction_arrow == '↑'
    assert Position.rand_position('E').direction_arrow == '→'
    assert Position.rand_position('S').direction_arrow == '↓'
    assert Position.rand_position('W').direction_arrow == '←'
  end

  def test_turn_right
    assert Position.new(0, 0, 'N').turn_right == Position.new(0, 0, 'E')
    assert Position.new(0, 0, 'E').turn_right == Position.new(0, 0, 'S')
    assert Position.new(0, 0, 'S').turn_right == Position.new(0, 0, 'W')
    assert Position.new(0, 0, 'W').turn_right == Position.new(0, 0, 'N')
  end

  def test_turn_left
    assert Position.new(0, 0, 'N').turn_left == Position.new(0, 0, 'W')
    assert Position.new(0, 0, 'E').turn_left == Position.new(0, 0, 'N')
    assert Position.new(0, 0, 'S').turn_left == Position.new(0, 0, 'E')
    assert Position.new(0, 0, 'W').turn_left == Position.new(0, 0, 'S')
  end

  def test_move
    assert Position.new(0, 0, 'N').move == Position.new(0, 1, 'N')
    assert Position.new(0, 0, 'E').move == Position.new(1, 0, 'E')
    assert Position.new(0, 0, 'S').move == Position.new(0, -1, 'S')
    assert Position.new(0, 0, 'W').move == Position.new(-1, 0, 'W')
    assert Position.new(0, 0, 'N').move(3) == Position.new(0, 3, 'N')
  end

  def test_equils
    assert Position.new(0, 0, 'N') == Position.new(0, 0, 'N')
    assert Position.new(0, 0, 'N') != Position.new(0, 0, 'S')
    assert Position.new(0, 0, 'N') != Position.new(0, 1, 'N')
    assert Position.new(0, 0, 'N') != Position.new(1, 0, 'N')
  end
  
  private
  def rand_coord
    rand(-1000..1000)
  end
end