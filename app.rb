require 'dotenv'
require 'dotenv/load'
require 'logger'

require './lib/prepared_files/check_input_files'
require './lib/prepared_files/read_content_files'
require './lib/prepared_files/check_directories'

require './service/apis/datajud/urls'
require './service/apis/datajud/call'

# Disable warning messages
$VERBOSE = nil

LOGGER = Logger.new($stdout)

status, err_check_directories = ::PreparedFiles::CheckDirectories.execute(LOGGER)

if status
  status, files = ::PreparedFiles::CheckInputFiles.execute(LOGGER)

  status, contents = ::PreparedFiles::ReadContentFiles.execute(LOGGER, files) if status

  status, contents = ::Service::Apis::Datajud::Call.execute(LOGGER, contents) if status
else
  msg = "Não foi possivel Criar OU Ler os arquivos do diretório ENTRADA. Detalhes: #{err_check_directories[:error]}"
  LOGGER.error(msg)
  puts msg
end
