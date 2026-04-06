

require './lib/read_xlsx_ods/read'

module PreparedFiles
  module ReadContentFiles
    extend self

    CONTENT = []

    def execute(log, analize_files)
      analize_files&.each_slice(25) do |group|
        group&.each do |file|
          load_content_file(log, file)
        end
      end

      CONTENT&.compact!
      CONTENT&.flatten!

      [true, CONTENT&.uniq]
    rescue StandardError => err
      puts err.message
      [false, err.message]
    end

    def load_content_file(log, file)
      CONTENT << ::ReadXlsxOds.read_file(log, file)
    end
  end
end
