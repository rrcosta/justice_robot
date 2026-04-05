# frozen_string_literal: true

module CheckInputFiles
  module_function
  extend self

  VALID_EXTENSIONS_FILE = %w[.xls .xlsx .ods .csv].freeze
  CHECK_INPUT_FILES = "#{Dir.pwd}/entrada"

  def execute(log = nil)
    analize_files = []
    invalid_files = []

    return [false, invalid_files] unless exists_files?(CHECK_INPUT_FILES)

    check_files.each_slice(25) do |group|
      group.each do |file|
        next unless File.file?(file)

        next unless VALID_EXTENSIONS_FILE.include?(File.extname(file))

        if File.zero?(file)
          populate_invalid_files(log, file, 'Arquivo conrrompido OU invalido')
          next
        else
          origem_file = file&.gsub(CHECK_INPUT_FILES, '')&.gsub(File&.basename(file), '')
          # Remove o ultimo '/'
          origem_file&.rstrip!('/')
          # responsavel por pegar de qual Tribunal sera o arquivo e sua respectiva subdivisao
          tmp_court = origem_file&.lstrip('/')&.rpartition('/')

          court     = tmp_court[0].nil? ? origem_file : tmp_court[0]
          sub_court = tmp_court[2].nil? ? origem_file : tmp_court[2]

          analize_files << {
            court: court,
            sub_court: sub_court,
            file: file,
            basename_file: File&.basename(file),
            extension_file: File.extname(file)
          }
        end
      end
    end

    [true, analize_files]
  rescue StandarError => err
    [false, err.message]
  end

  def dta_now
    Time.now.strftime('%F_%H%m%S')
  end

  def check_files
    Dir.glob("#{CHECK_INPUT_FILES}/**/*")
  end

  def exists_files?(file)
    File.directory?(file)
  end

  def populate_invalid_files(log, file, motive)
    invalid_files << {
      file: File&.basename(file),
      error: motive
    }

    log.warn(motive)
  end
end
