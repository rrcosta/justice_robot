require './lib/read_xlsx_ods/read'

RSpec.describe ReadXlsxOds do
  let(:log) do
    Logger.new($stdout)
  end

  let(:file_name) do
    "justice_robot/entrada/TRIBUNAL_JUSTICA_ESTADUAL/SP/01.xlsx"
  end

  let(:file) do
    {
      court: "TRIBUNAL_JUSTICA_ESTADUAL",
      sub_court: "SP",
      file: file_name,
      basename_file: "01.xlsx",
      extension_file: ".xlsx"
    }
  end

  describe '#name_of_file' do
    it 'returns the name of file' do
      expect(described_class::name_of_file(file)).to eql(file_name)
    end
  end

  describe '#read_file' do
    let(:result) do
      described_class::read_file(log, file)
    end

    it 'returns a array' do
      expect(result.class).to eql(Array)
    end

    context 'failed' do
      #cont(:result) { described_class::read_file(log, file) }

      it 'returns the first element with false' do
        expect(result[0]).to be_falsey
      end

      it 'returns the message of fail at second element' do
        expect(result[1]).to eql("file justice_robot/entrada/TRIBUNAL_JUSTICA_ESTADUAL/SP/01.xlsx does not exist")
      end
    end
  end
end
