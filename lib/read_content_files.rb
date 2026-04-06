require 'simple-spreadsheet'

# Disable warning messages
$VERBOSE = nil

module ReadContentFiles
  extend self

  SIZE_CHARS_NUMBER_PROCESS = 20.freeze
  CONTENT = []

  def execute(log, analize_files)
    # SAMPLE of struct
    # {
    #   court: "TRIBUNAL_JUSTICA_ESTADUAL",
    #   sub_court: "SP",
    #   file: "/home/rafael/Development/r2c/justice_robot/entrada/TRIBUNAL_JUSTICA_ESTADUAL/SP/01.xlsx",
    #   basename_file: "01.xlsx",
    #   extension_file: ".xlsx"
    #   }

    analize_files&.each_slice(25) do |group|
      group&.each do |file|
        load_content_file(log, file)
      end
    end

    CONTENT&.compact!

    [true, CONTENT&.uniq]
  rescue StandardError => err
    puts err.message
    [false, err.message]
  end

  def load_content_file(log, file)
    file_name = file[:file]

    s = SimpleSpreadsheet::Workbook.read(file_name)

    s.selected_sheet = s.sheets.first

    s.first_row.upto(s.last_row) do |line|
      #s.cell(linha, coluna)
      process_number = s.cell(line, 1)&.strip

      CONTENT << {
        court: file[:court],
        sub_court: file[:sub_court],
        basename_file: file[:basename_file],
        number_process: process_number,
        number_process_withoutmask: number_process_without_mask(process_number),
      } unless process_number.nil?
    end
  end

  def number_process_without_mask(process_number)
    adds_left_zero_chars_at_process_number(
      process_number&.gsub('-','')&.gsub('.','')&.gsub('/','')&.gsub('?','')&.gsub('!','')
    )
  end

  # Retona o numero do processo com zeros a esquerda ate completar 20 digitos
  def adds_left_zero_chars_at_process_number(num_proces)
    size_complement_size = num_proces&.size

    complement_char = (SIZE_CHARS_NUMBER_PROCESS - size_complement_size)
    complement_char = complement_char.negative? ? complement_char&.abs : complement_char

    new_num_proces = "0" * complement_char + num_proces

    new_num_proces
  rescue
    num_proces
  end
end
