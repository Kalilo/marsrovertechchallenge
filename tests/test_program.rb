# frozen_string_literal: true

require 'minitest/autorun'
require 'program'

class ProgramTest < Minitest::Test
  def test_run_file
    assert_raises { Program.new(file: 'tests/bad_command.txt').run_file }
    assert_raises { Program.new(file: 'tests/bad_map_size.txt').run_file }
    assert_raises { Program.new(file: 'tests/bad_rover.txt').run_file }
  end
end
