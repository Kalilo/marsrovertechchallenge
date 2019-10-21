# frozen_string_literal: true

$LOAD_PATH.unshift File.join(__dir__, 'tests')
$LOAD_PATH.unshift File.join(__dir__, 'srcs')

Dir[File.join(__dir__, 'tests', '*.rb')].each { |file| require file }
