require 'dotenv'
require 'dotenv/load'
require 'logger'

require './lib/prepared_files/check_input_files'
require './lib/prepared_files/read_content_files'
require './lib/prepared_files/check_directories'

require './services/apis/urls'
require './services/apis/datajud'

# Disable warning messages
$VERBOSE = nil

LOGGER = Logger.new($stdout)

status, _ = ::PreparedFiles::CheckDirectories.execute(LOGGER)

if status
  status, files = ::PreparedFiles::CheckInputFiles.execute(LOGGER)

  status, contents = ::PreparedFiles::ReadContentFiles.execute(LOGGER, files) if status

  puts contents

  

else
  msg = "Não foi possivel Criar OU Ler os arquivos do diretório ENTRADA"
  LOGGER.error(msg)
  puts mgs
end


status, contents = ::Apis::Datajud.call(LOGGER, contents) if status

#Processo: 10011963820225020712
# {"took":9444,"timed_out":false,"_shards":{"total":1,"successful":1,"skipped":0,"failed":0},"hits":{"total":{"value":0,"relation":"eq"},"max_score":null,"hits":[]}}