require 'minitest/autorun'
require 'rover'

class RoverTest < Minitest::Test

  def test_initialize
    assert_kind_of Rover, Rover.new
    assert_kind_of Rover, Rover.new(Position.rand_position)
    assert_kind_of Rover, Rover.new(Position.rand_position, 5.times.map { Command.rand_command })
  end

  def test_execute_command_with_given_command
    rover = Rover.new(Position.new(0, 0, 'N'))

    assert rover.execute_command(Command.new('M')) == Position.new(0, 1, 'N')
    assert rover.execute_command(Command.new('L')) == Position.new(0, 0, 'W')
    assert rover.execute_command(Command.new('R')) == Position.new(0, 0, 'E')

    assert rover.execute_command(Command.new('M')) != rover.position
    ['M', nil, [], 2].each do |c|
      assert_raises { rover.execute_command(c) }
    end
  end

  def test_execute_command
    rover = Rover.new(Position.new(0, 0, 'N'), [Command.new('M'), Command.new('L'), Command.new('R')])

    assert rover.execute_command == Position.new(0, 1, 'N')
    assert rover.has_next_command?
    assert rover.execute_command == Position.new(0, 0, 'W')
    assert rover.has_next_command?
    assert rover.execute_command == Position.new(0, 0, 'E')
    assert !(rover.has_next_command?)
  end
end