$LOAD_PATH.unshift File.join(__dir__, 'tests')

Dir[File.join(__dir__, 'tests', '*.rb')].each { |file| require file }