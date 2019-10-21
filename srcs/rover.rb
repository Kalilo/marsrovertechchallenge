# frozen_string_literal: true

require 'position'
require 'command'

class Rover
  attr_accessor :position, :commands

  def initialize(position = Position.new(0, 0, 'N'), commands = [])
    self.position = position
    self.commands = commands
  end

  def execute_command(command = nil)
    command ||= @commands.shift
    raise 'no command found to execute' if command.nil?

    case command.command
    when 'L'
      @position.turn_left
    when 'R'
      @position.turn_right
    when 'M'
      @position.move
    else
      raise "invalid command: #{command}"
    end
  end

  def next_command?
    @commands.any?
  end

  def to_s
    "< Rover: #{@position} >"
  end

  def inspect
    to_s
  end
end
