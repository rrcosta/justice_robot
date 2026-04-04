require 'dotenv'
require 'dotenv/load'
require 'logger'

require './lib/check_input_files'
require './lib/read_content_files'

LOGGER = Logger.new($stdout)

status, analize_files = CheckInputFiles.load_files(LOGGER)

status, contents = ReadContentFiles.execute(LOGGER, analize_files) if status

puts contents if status

puts ENV.fetch('TOKEN_API', 'Nao carregado')