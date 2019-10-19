require 'minitest/autorun'
require './srcs/command.rb'

class CommandTest < Minitest::Test
  def test_invalid_commands
    invalid_commands = (('A'..'Z').map { |l| l  } - Command::VALID_COMMANDS) + [1, nil, 'Right']

    invalid_commands.each do |c|
      assert_raises { Command.new(c) }
    end
  end

  def test_valid_commands
    Command::VALID_COMMANDS.each do |c|
      assert_kind_of Command, Command.new(c)
    end
  end

  def test_rand_command
    3.times do
      assert_kind_of Command, Command.rand_command
    end
  end
end