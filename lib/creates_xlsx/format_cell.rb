module CreatesXlsx
  module FormatCell
    def heading_movements(workbook)
      workbook.add_format(
        bold:  1,
        italic: 1,
        color: ::CreatesXlsx::Util::CUSTOM_COLORS[:pearl_aqua],
        size:  13,
        merge: 9,
        align: 'vcenter',
        center_across: 2,
        fg_color: ::CreatesXlsx::Util::CUSTOM_COLORS[:teal_dark],
        valign: 'vcenter'
      )
    end

    def title_cell_movements(workbook)
      workbook.add_format(
        bold:  1,
        font:  'Calibri',
        size:  11,
        merge: 9,
        align: 'left',
        valign: 'vcenter',
        fg_color: ::CreatesXlsx::Util::CUSTOM_COLORS[:black_cherry],
        color: ::CreatesXlsx::Util::CUSTOM_COLORS[:white_smoke],
      )
    end

    def title_info_process(workbook)
      workbook.add_format(
        bold:  1,
        font:  'Calibri',
        size:  12,
        align: 'left',
        valign: 'vcenter',
        color: ::CreatesXlsx::Util::CUSTOM_COLORS[:teal_dark],
      )
    end

    def title_detail_info_process(workbook)
      workbook.add_format(
        bold:  1,
        font:  'Calibri',
        size:  10,
        align: 'left',
        color: ::CreatesXlsx::Util::CUSTOM_COLORS[:white_smoke],
        fg_color: ::CreatesXlsx::Util::CUSTOM_COLORS[:rosado],
      )
    end

    def content_cell_movements(workbook)
      workbook.add_format(
        bold:  0,
        font:  'Verdana',
        size:  11,
        merge: 13,
        align: 'left',
        valign: 'vcenter',
        color: ::CreatesXlsx::Util::CUSTOM_COLORS[:charcoal],
      )
    end

    def last_movement_format_title(workbook)
      workbook.add_format(
        bold:  1,
        font:  'Calibri',
        color: ::CreatesXlsx::Util::CUSTOM_COLORS[:pearl_aqua],
        fg_color: ::CreatesXlsx::Util::CUSTOM_COLORS[:teal_dark],
      )
    end

    def last_movement_format_contet(workbook)
      workbook.add_format(
        border: 1,
        bold:  1,
        size:  12,
        border_color:  ::CreatesXlsx::Util::CUSTOM_COLORS[:teal_dark],
      )
    end
  end
end
