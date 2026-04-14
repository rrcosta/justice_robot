require 'date'
require 'json'
require './lib/creates_xlsx/util'

RSpec.describe CreatesXlsx::Util do
  let(:colors) do
    {
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
  end

  let(:struct) do
    JSON.parse(
      {
        number_process: '0000',
        classe_process: 'TRAB',
        process_format: 'DIGITAL',
        court: 'TRIBUNAL_JUSTICA_ESTADUAL',
        sub_court: 'SP',
        subject_process: 'FOO',
        orgao_julgador: 'JUSTICA',
        api_datajud_id: 'ID_001_AAA',
        last_updated_info: '2025'
      }.to_json
    )
  end

  describe 'Constants' do
    describe 'CUSTOM_COLORS' do
      it 'returns hash of hexa colors' do
        expect(described_class::CUSTOM_COLORS.keys).to eql(colors.keys)
      end
    end
  end

  describe '#format_file_name' do
    let(:expected_formart) do
      "/#{DateTime.now.strftime('%d%m%Y_%H%M')}_Result.xlsx"
    end

    it 'returns the title of file' do
      expect(described_class::format_file_name).to eql(expected_formart)
    end
  end

  describe '#numero_process' do
    it 'returns the number of process at struct' do
      expect(described_class::numero_process(struct)).to eql(struct['number_process'])
    end
  end

  describe '#classe_processo' do
    it 'returns the class of process at struct' do
      expect(described_class::classe_processo(struct)).to eql(struct['classe_process'])
    end
  end

  describe '#process_format' do
    it 'returns the format of process at struct' do
      expect(described_class::process_format(struct)).to eql(struct['process_format'])
    end
  end

  describe '#tribunal' do
    it 'returns the format of process at struct' do
      expect(described_class::tribunal(struct)).to eql(struct['court'])
    end
  end

  describe '#subtribunal' do
    it 'returns the format of process at struct' do
      expect(described_class::subtribunal(struct)).to eql(struct['sub_court'])
    end
  end

  describe '#assunto_process' do
    it 'returns the format of process at struct' do
      expect(described_class::assunto_process(struct)).to eql(struct['subject_process'])
    end
  end

  describe '#foro' do
    it 'returns the format of process at struct' do
      expect(described_class::foro(struct)).to eql(struct['orgao_julgador'])
    end
  end

  describe '#fonte_informacao_api' do
    it 'returns the format of process at struct' do
      expect(described_class::fonte_informacao_api(struct)).to eql(struct['api_datajud_id'])
    end
  end

  describe '#ultima_atualizacao_process' do
    it 'returns the format of process at struct' do
      expect(described_class::ultima_atualizacao_process(struct)).to eql(struct['last_updated_info'])
    end
  end
end