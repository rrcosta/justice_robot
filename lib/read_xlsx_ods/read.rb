require 'simple-spreadsheet'

module ReadXlsxOds
  extend self

  ## SAMPLE of struct
  #  {
  #    court: "TRIBUNAL_JUSTICA_ESTADUAL",
  #    sub_court: "SP",
  #    file: "/home/rafael/Development/r2c/justice_robot/entrada/TRIBUNAL_JUSTICA_ESTADUAL/SP/01.xlsx",
  #    basename_file: "01.xlsx",
  #    extension_file: ".xlsx"
  #  }
  def read_file(log, file)
    returned_array = []

    s = SimpleSpreadsheet::Workbook.read(name_of_file(file))

    s.selected_sheet = s.sheets.first

    s.first_row.upto(s.last_row) do |line|
      #s.cell(linha, coluna)
      process_number = s.cell(line, 1)&.strip

      returned_array << {
        court: file.dig(:court) || '',
        sub_court: file.dig(:sub_court) || '',
        basename_file: file.dig(:basename_file) || '',
        number_process: process_number,
        number_process_withoutmask:process_number&.gsub('-','')&.gsub('.','')&.gsub('/','')&.gsub('?','')&.gsub('!',''),
      } unless process_number.nil?
    end

    returned_array
  rescue StandardError => err
    puts err.message
    [false, err.message]
  end

  def name_of_file(struct)
    return struct if struct.instance_of?(String)

    struct.dig(:file)
  end
end