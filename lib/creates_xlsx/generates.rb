require 'write_xlsx'

require './lib/creates_xlsx/util'
require './lib/creates_xlsx/format_cell'

module CreatesXlsx
  module Generates
    extend self

    include ::CreatesXlsx::Util
    include ::CreatesXlsx::FormatCell

    # lambdas
    FIRST_AND_LAST_MOV = -> (struct) do
      begin
        return [] if struct.nil?
        struct.sort_by { |item| Date.parse( JSON.parse(item)['date'] ) }
      rescue
        [struct.first, struct.last]
      end
    end

    FORMAT_DESCRIPTION = -> (struct) do
      begin
        return '' if struct.nil?
        "#{struct&.dig('date')} - #{struct&.dig('name')}"
      rescue
        ""
      end
    end

    def execute(log, dir_struct, pre_xls)
      workbook = WriteXLSX.new(
        creates_name_file(log, dir_struct)
      )

      generates_content_file(workbook, pre_xls)

      workbook.close

      workbook
    rescue StandardError => e
      puts "ERRO ao tentar gerar a Planilha Excel. Detalhes: #{e.message}"
    end

    def generates_content_file(workbook, pre_xls)
      worksheet_movements = workbook.add_worksheet('Movimentos')

      headings = ["    Movimentos / Andamentos do Processo #{numero_process(pre_xls)}    " , '', '']
      worksheet_movements.merge_range('A1:D1', headings, heading_movements(workbook))

      worksheet_movements.set_column('A:A', 29)
      worksheet_movements.set_column('B:B', 63)
      worksheet_movements.set_column('C:D', 37)

      worksheet_movements.write('A3', 'Assunto', title_info_process(workbook))
      worksheet_movements.write('B3', assunto_process(pre_xls) )

      worksheet_movements.write('A4', 'Foro', title_info_process(workbook))
      worksheet_movements.write('B4', foro(pre_xls))

      worksheet_movements.write('A6', 'Tribunal', title_info_process(workbook))
      worksheet_movements.write('B6', tribunal(pre_xls))

      worksheet_movements.write('A7', 'Sub Tribunal', title_info_process(workbook))
      worksheet_movements.write('B7', subtribunal(pre_xls))

      worksheet_movements.write('A9', 'Fonte de Informação', title_info_process(workbook))
      worksheet_movements.write('B9', fonte_informacao_api(pre_xls))

      worksheet_movements.write('A10', 'Ultima Atualização do Processo', title_info_process(workbook))
      worksheet_movements.write('B10', ultima_atualizacao_process(pre_xls))

      movements = FIRST_AND_LAST_MOV.call( pre_xls.dig('movements') )

      first_movement, last_movement = first_and_last_movement(movements)

      worksheet_movements.write('A13', 'Primeiro Movimento', last_movement_format_title(workbook))
      worksheet_movements.write('B13', FORMAT_DESCRIPTION.call(first_movement), last_movement_format_contet(workbook))

      worksheet_movements.write('A15', 'Último Movimento', last_movement_format_title(workbook))
      worksheet_movements.write('B15', FORMAT_DESCRIPTION.call(last_movement), last_movement_format_contet(workbook))

      worksheet_movements.write('A18', 'Data: '                    , title_detail_info_process(workbook))
      worksheet_movements.write('B18', 'Descrição: '               , title_detail_info_process(workbook))
      worksheet_movements.write('C18', 'Detalhes: '                , title_detail_info_process(workbook))
      worksheet_movements.write('D18', 'Descrição do complemento:' , title_detail_info_process(workbook))

      movements.each_with_index do |content, key|
        new_key = key + 19
        content_explain = JSON.parse(content)

        worksheet_movements.write("A#{new_key}", content_explain&.dig('date'), content_cell_movements(workbook))
        worksheet_movements.write("B#{new_key}", content_explain&.dig('name'), content_cell_movements(workbook))

        number_complements = content_explain&.dig('complement')

        next if number_complements.nil?

        number_complements.each do |complement|
          cn = complement&.dig('complement_name')
          worksheet_movements.write("C#{new_key}", cn, content_cell_movements(workbook)) unless cn.nil?

          ty = complement&.dig('complement_description')
          worksheet_movements.write("D#{new_key}", ty, content_cell_movements(workbook)) unless ty.nil?
        end
      end


      worksheet_movements.autofilter("A18:D#{movements.size + 1}")
    end

    def first_and_last_movement(struct)
      mov = FIRST_AND_LAST_MOV.call(struct)

      [ JSON.parse(mov&.first) , JSON.parse(mov&.last)]
    rescue
      [JSON.parse(struct.first), JSON.parse(struct.last)]
    end
  end
end
