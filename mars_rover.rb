$LOAD_PATH.unshift File.join(__dir__, 'srcs')

require 'parse_args'
require 'program'

Program.new(@options).run_file