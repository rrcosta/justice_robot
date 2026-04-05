require 'dotenv'
require 'dotenv/load'
require 'logger'

require './lib/check_input_files'
require './lib/read_content_files'
require './lib/check_directories'

require './services/apis/urls'
require './services/apis/datajud'

LOGGER = Logger.new($stdout)

status, _ = CheckDirectories.execute(LOGGER)

if status
  status, analize_files = CheckInputFiles.load_files(LOGGER)

  status, contents = ReadContentFiles.execute(LOGGER, analize_files) if status

  status, contents = ::Apis::Datajud.call(LOGGER, contents) if status

else
  msg = "Não foi possivel Criar OU Ler os arquivos do diretório ENTRADA"
  LOGGER.error(msg)
  puts mgs
end
