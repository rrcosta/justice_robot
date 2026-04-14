require 'spec_helper'
require 'logger'

require './lib/prepared_files/read_content_files'

RSpec.describe PreparedFiles::ReadContentFiles do

  let(:log) do
    Logger.new($stdout)
  end

  let(:analize_files) do
    ('A'..'Z').to_a
  end

  before do
    allow(described_class).to receive(:load_content_file).and_return([])
  end

  describe '#execute' do

    it 'returns a array with a boolen as first element and array at second element' do
      result = described_class::execute(log, analize_files)

      expect(result.class).to eql(Array)

      expect(result[0]).to be_truthy
      expect(result[1]).to eql([])
    end
  end
end