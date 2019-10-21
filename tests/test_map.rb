# frozen_string_literal: true

require 'minitest/autorun'
require 'map'

class MapTest < Minitest::Test
  def test_initialize
    assert_kind_of Map, Map.new(10, 10)
    [nil, [], '', -1, 0, -100].each do |c|
      assert_raises { Map.new(10, c) }
      assert_raises { Map.new(c, 10) }
    end
  end

  def test_add_rover
    map = Map.new(10, 10)
    r1 = Rover.new(Position.new(0, 0, 'N'))
    map.add_rover(r1)
    assert map.rovers[0] == r1
    assert map.map[0][0] == r1
    assert_raises { map.add_rover(Rover.new(Position.new(0, 0, 'E'))) }
    assert_raises { map.add_rover(Rover.new(Position.new(11, 0, 'N'))) }
    assert_raises { map.add_rover(Rover.new('R')) }
    map.add_rover(Rover.new(Position.new(4, 2, 'N')))
  end

  def test_execute_rover_command
    map = Map.new(10, 10)
    r1 = Rover.new(Position.new(0, 0, 'E'), [Command.new('M'), Command.new('L'), Command.new('M')])
    r2 = Rover.new(Position.new(1, 1, 'N'))
    map.add_rover(r1)
    map.add_rover(r2)
    map.execute_rover_command(r1)

    assert map.map[0][0].nil?
    assert map.map[1][0] == r1

    map.execute_rover_command(r1)
    assert_raises { map.execute_rover_command(r1) }
    assert map.map[1][0] == r1
    assert map.map[1][1] == r2
  end
end
