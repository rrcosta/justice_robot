require 'simple-spreadsheet'

# Disable warning messages
$VERBOSE = nil

module ReadContentFiles
  extend self

  CONTENT = []

  def execute(log, analize_files)
    # SAMPLE of struct
    # {file: "/home/rafael/Development/r2c/justice_robot/entrada/01.xlsx", basename_file: "01.xlsx", extension_file: ".xlsx"}
    # {file: "/home/rafael/Development/r2c/justice_robot/entrada/01_.ods", basename_file: "01_.ods", extension_file: ".ods"}

    analize_files&.each_slice(25) do |group|
      group&.each do |file|
        #file[:file],
        #file[:basename_file],
        #file[:extension_file]
        load_content_file(log, file[:file], file[:basename_file])
      end
    end

    CONTENT&.compact!

    [true, CONTENT&.uniq]
  rescue StandardError => err
    puts err.message
    [false, err.message]
  end

  def load_content_file(log, file, basename_file = nil)
    s = SimpleSpreadsheet::Workbook.read(file)

    s.selected_sheet = s.sheets.first

    s.first_row.upto(s.last_row) do |line|
      #s.cell(linha, coluna)
      number_process = s.cell(line, 1)&.strip
      publication    = s.cell(line, 3)&.strip

      CONTENT << {
        number_process: number_process,
        number_process_withoutmask: number_process&.gsub('-','')&.gsub('.',''),
        publication: publication,
      } unless number_process.nil?
    end
  end
end
