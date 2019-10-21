# frozen_string_literal: true

class Command
  attr_reader :command

  VALID_COMMANDS = %w[M L R].freeze

  def initialize(char)
    self.command = char
  end

  def self.rand_command
    Command.new(VALID_COMMANDS.sample)
  end

  def to_s
    "< Command: #{command} >"
  end

  def inspect
    to_s
  end

  def command=(char)
    raise 'invalid command' unless VALID_COMMANDS.include?(char)

    @command = char
  end
end
