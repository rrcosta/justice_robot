require 'spec_helper'

require './lib/prepared_files/tools'

RSpec.describe PreparedFiles::Tools do
  describe '#Constant' do
    it 'VALID_EXTENSIONS_FILE' do
      expect(described_class::VALID_EXTENSIONS_FILE).to eql([".xls", ".xlsx", ".ods", ".csv"])
    end
  end

  describe '#extension_file_valid?' do
    context 'success' do
      it 'true' do
        %w[.xls .xlsx .ods .csv].each do |extension|
          expect(described_class::extension_file_valid?(extension)).to be_truthy
        end
      end
    end

    context 'failed' do
      it 'false' do
        expect(described_class::extension_file_valid?('.txt')).to be_falsey
      end
    end
  end

  describe '#msg_date_now' do
    it 'returns date and hours with string formation' do
      expect(described_class::msg_date_now).to eql(Time.now.strftime('%F_%H%m%S_'))
    end
  end
#
  describe '#exists_files_or_directory?' do
    it 'should returns false' do
      expect(
        described_class::exists_files_or_directory?('XLLS')
      ).to be_falsey
    end
  end

  describe '#check_files' do
    it 'should not be nil' do
      expect(described_class::check_files('sample')).not_to be_nil
    end
  end

  describe '#basename_of_file' do
    it 'should not be nil' do
      expect(described_class::basename_of_file('sample.xls')).not_to be_nil
    end
  end

  describe '#extension_of_file' do
    it 'shoulds returns xlsx' do
      expect(described_class::extension_of_file('sample.xlsx')).to eql(".xlsx")
    end
  end

  describe '#creates_folders_at_array' do
    it 'should returns empty array' do
      expect(described_class::creates_folders_at_array([])).to eql([])
    end
  end

  describe '#court_name_by_directory' do
    it 'returns nil' do
      expect(described_class::court_name_by_directory('/sample.rb', '/')).to be_nil
    end
  end

  describe '#get_court_and_sub_court_by_origin_name' do
    it 'returns a array with 2 items of empty strings' do
      expect(
        described_class::get_court_and_sub_court_by_origin_name(nil)
      ).to eql(['', ''])
    end
  end

  describe '#removes_invalid_chars' do
    it "returns 'msg' without points" do
      str = 'msg.//-./'
      expect(described_class::removes_invalid_chars(str)).to eql('msg')
    end
  end

  describe '#adds_left_zero_chars_at_process_number' do
    it "returns the number with 0 before number of process" do
      limit_chars_number = 20
      num_proces = '681891'

      num = described_class::adds_left_zero_chars_at_process_number(num_proces, limit_chars_number)

      expect(num.size).to eql(limit_chars_number)

      expect(num).to eql("00000000000000681891")
    end
  end
end