# frozen_string_literal: true

describe FileReaderService do
  subject(:data) { described_class.file_stream(path) }

  shared_examples 'raises a FileError' do
    it 'works correctly' do
      expect { data }.to raise_error(FileError)
    end
  end

  context 'when file path is nil' do
    let(:path) { nil }

    it_behaves_like 'raises a FileError'
  end

  context 'when file path is empty string' do
    let(:path) { '' }

    it_behaves_like 'raises a FileError'
  end

  context 'points to a dir' do
    let(:path) { './spec/fixtures' }

    it_behaves_like 'raises a FileError'
  end

  context 'when file does not exist' do
    let(:path) { './spec/fixtures/absent_file' }

    it_behaves_like 'raises a FileError'
  end

  context 'when file path is correct' do
    let(:path) { './spec/fixtures/valid_logs' }
    let(:count_expected) { 100 }

    it 'read file correctly' do
      expect { data }.not_to raise_error
      expect(data).to be_a File
      expect(data.count).to eq(count_expected)
    end
  end
end
