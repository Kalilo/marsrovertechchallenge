# frozen_string_literal: true

require 'minitest/autorun'
require 'read_file'

class ReadFileTest < Minitest::Test
  def test_read_file
    assert_raises { ReadFile.new('tests/bad_map_size2.txt').read }
    assert_raises { ReadFile.new('tests/bad_rover.txt').read }
  end
end
