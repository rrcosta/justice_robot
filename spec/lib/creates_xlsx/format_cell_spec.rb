require 'write_xlsx'

require './lib/creates_xlsx/format_cell'
require './lib/creates_xlsx/util'

RSpec.describe CreatesXlsx::FormatCell do

  let(:workbook) do
    double(WriteXLSX)
  end

  before do
    allow(workbook).to receive(:add_format).and_return(:true)

    allow(::CreatesXlsx::Util::CUSTOM_COLORS).to receive(:pearl_aqua).and_return('#B0E2DD')
    allow(::CreatesXlsx::Util::CUSTOM_COLORS).to receive(:teal_dark).and_return('#0E536A')
    allow(::CreatesXlsx::Util::CUSTOM_COLORS).to receive(:black_cherry).and_return('#6C1616')
    allow(::CreatesXlsx::Util::CUSTOM_COLORS).to receive(:white_smoke).and_return('#F5F5F5')
    allow(::CreatesXlsx::Util::CUSTOM_COLORS).to receive(:rosado).and_return('#D20A2E')
    allow(::CreatesXlsx::Util::CUSTOM_COLORS).to receive(:charcoal).and_return('#4F5253')
  end

  describe 'heading_movements' do
    it 'should returns true' do
      expect(described_class::heading_movements(workbook)).to be_truthy
    end
  end

  describe 'title_info_process' do
    it 'should returns true' do
      expect(described_class::title_info_process(workbook)).to be_truthy
    end
  end

  describe 'title_detail_info_process' do
    it 'should returns true' do
      expect(described_class::title_detail_info_process(workbook)).to be_truthy
    end
  end

  describe 'content_cell_movements' do
    it 'should returns true' do
      expect(described_class::content_cell_movements(workbook)).to be_truthy
    end
  end

  describe 'last_movement_format_title' do
    it 'should returns true' do
      expect(described_class::last_movement_format_title(workbook)).to be_truthy
    end
  end

  describe 'last_movement_format_contet' do
    it 'should returns true' do
      expect(described_class::last_movement_format_contet(workbook)).to be_truthy
    end
  end


  describe 'title_cell_movements' do
    it 'should returns true' do
      expect(described_class::title_cell_movements(workbook)).to be_truthy
    end
  end
end
