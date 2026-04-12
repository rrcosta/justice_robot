require './lib/prepared_files/creates_final_directories'

module CreatesXlsx
  module Util

    CUSTOM_COLORS = {
      white:             '#FFFFFF',
      white_smoke:       '#F5F5F5',
      blue:              '#8B9EB7',
      pearl_aqua:        '#B0E2DD',
      light_green:       '#B4F88F',
      lawn_green:        '#76E813',
      green_shamrock:    '#5E9B70',
      tropical_mint:     '#13E89D',
      medium_jungle:     '#5AAB58',
      green_blue_spruce: '#0E6A5B',
      green_dark_emerald:'#0E6A46',
      green:             '#176A0E',
      dusty_olive1:      '#6D9075',
      dusty_olive2:      '#7F906D',
      dark_cyan:         '#539196',
      blue_green:        '#5895AB',
      neon_ice:          '#13E4E8',
      blue_bell:         '#139DE8',
      azure_blue:        '#137AE8',
      royal_azure:       '#134BE8',
      ultrasonic_blue:   '#2F13E8',
      blue_imperial:     '#0E2A6A',
      teal_dark:         '#0E536A',
      yale_blue:         '#2E4667',
      olive_dark:        '#6A610E',
      bronze:            '#F3B351',
      tiger_orage:       '#E88113',
      rose:              '#E3B5B1',
      coral:             '#F7685B',
      red_vibrant_coral: '#F35F51',
      tomato:            '#F36C51',
      melancia:          '#FC6C85',
      fuchsia_plum:      '#AB5885',
      rosewood:          '#AB5873',
      racing_red:        '#E81313',
      red_tomato:        '#C43131',
      rosado:            '#D20A2E',
      razzmatazz:        '#E8136F',
      amaranth:          '#E81353',
      primary_scarlet:   '#E81324',
      red_dark:          '#6A0E0E',
      black_cherry:      '#6C1616',
      dust_mauve:        '#906D74',
      eletric_rose:      '#E8139D',
      vivid_orchid:      '#E813D6',
      purple:            '#A813E8',
      medium_state_blue: '#6E76E7',
      dim_grey:          '#656C6C',
      charcoal:          '#4F5253',
      dark_slate_grey:   '#425658',
      granite:           '#425844',
      teal_granite:      '#425852',
    }

    def format_file_name
      "/#{DateTime.now.strftime('%d%m%Y_%H%M')}_Result.xlsx"
    end

    def directory_name(log, dir_struct)
      ::PreparedFiles::CreatesFinalDirectories.execute(log, dir_struct)
    end

    def creates_name_file(log, dir_struct)
      directory_name(log, dir_struct) + format_file_name
    end

    def numero_process(pre_xls)
      pre_xls.dig('number_process')&.to_s
    end

    def classe_processo(pre_xls)
      pre_xls.dig('classe_process')
    end

    def process_format(pre_xls)
      pre_xls.dig('process_format')
    end

    def tribunal(pre_xls)
      pre_xls.dig('court')
    end

    def subtribunal(pre_xls)
      pre_xls.dig('sub_court')
    end

    def assunto_process(pre_xls)
      pre_xls.dig('subject_process')
    end

    def foro(pre_xls)
      pre_xls.dig('orgao_julgador')
    end

    def fonte_informacao_api(pre_xls)
      pre_xls.dig('api_datajud_id')
    end

    def ultima_atualizacao_process(pre_xls)
      pre_xls.dig('last_updated_info')
    end
  end
end

# ::CreatesXlsx::Util::CUSTOM_COLORS[]