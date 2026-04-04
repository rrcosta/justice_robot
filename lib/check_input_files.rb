# frozen_string_literal: true

module CheckInputFiles
  module_function
  extend self

  VALID_EXTENSIONS_FILE = %w[.xls .xlsx .ods .csv].freeze
  CHECK_INPUT_FILES = "#{Dir.pwd}/entrada"

  def load_files(log = nil)
    analize_files = []
    invalid_files = []

    # Checar se tem arquivo XLS dentro da pasta ENTRADA
    if exists_files?(log)
      check_files.each_slice(25) do |group|
        group.each do |file|
          if VALID_EXTENSIONS_FILE.include?(File.extname(file))
            if File.zero?(file)
              invalid_files << {
                file: file,
                error: 'Arquivo conrrompido OU invalido'
              }
              next
            else
              analize_files << {
                file: file,
                basename_file: File&.basename(file),
                extension_file: File.extname(file)
              }
            end
          else
            invalid_files << {
              file: File&.basename(file),
              error: "Extensao: '#{File.extname(file)}' nao é valida"
            }
          end
        end
      end

      msg_log_invalid_files(log, invalid_files) if invalid_files.size > 0

      return true, analize_files if analize_files.size.positive?
    else
      invalid_files << { file: '', error: msg_files_not_exists }
    end

    [false, invalid_files]
  rescue StandarError => err
    [false, err.message]
  end

  def dta_now
    Time.now.strftime('%F_%H%m%S')
  end

  def check_files
    Dir.glob("#{CHECK_INPUT_FILES}/**/*")
  end

  def msg_files_not_exists
    "#{dta_now}__Pasta_Diretorio_ENTRADA_nao_localizada_na_raiz_deste_projeto"
  end

  def exists_files?(log)
    return true if File.directory?(CHECK_INPUT_FILES)

    log.error(msg_files_not_exists)
  end

  def msg_log_invalid_files(log, invalid_files)
    invalid_files&.each do |inv_fle|
      log.warn("#{inv_fle[:error]} - File: #{inv_fle[:file]}")
    end
  end
end
