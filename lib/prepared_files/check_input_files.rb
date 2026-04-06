require './lib/prepared_files/tools'

module PreparedFiles
  module CheckInputFiles
    module_function
    extend self

    include ::PreparedFiles::Tools

    CHECK_INPUT_FILES = "#{Dir.pwd}/entrada"

    def execute(log = nil)
      analize_files = []
      invalid_files = []

      return [false, invalid_files] unless exists_files_or_directory?(CHECK_INPUT_FILES)

      check_files("#{CHECK_INPUT_FILES}/**/*").each_slice(25) do |group|
        group.each do |file|
          next unless File.file?(file)

          next unless extension_file_valid?(extension_of_file(file))

          if File.zero?(file)
            populate_invalid_files(log, file, 'Arquivo corrompido OU invalido')
            next
          else
            court, sub_court = get_court_and_sub_court_by_origin_name(
              court_name_by_directory(file, CHECK_INPUT_FILES)
            )

            analize_files << {
              court: court,
              sub_court: sub_court,
              file: file,
              basename_file: basename_of_file(file),
              extension_file: extension_of_file(file)
            }
          end
        end
      end

      [true, analize_files]
    rescue StandarError => err
      [false, err.message]
    end

    def populate_invalid_files(log, file, motive)
      invalid_files << { file: basename_of_file(file), error: motive }

      log.warn(motive)
    end
  end
end

