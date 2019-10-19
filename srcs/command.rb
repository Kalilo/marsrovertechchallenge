class Command
  attr_reader :command

  VALID_COMMANDS = %W'M L R'

  def initialize(c)
    self.command = c
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

  def command=(c)
    raise 'invalid command' unless VALID_COMMANDS.include?(c)
    @command = c
  end
end