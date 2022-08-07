# frozen_string_literal: true

describe ParsingService do
  describe '#call' do
    subject(:logs) { described_class.call(path) }

    shared_examples 'file processing' do
      it 'works correctly' do
        expect(logs.instance_of?(Array)).to be_truthy
        expect(logs.count).to eq(count_expected)
      end
    end

    shared_examples 'rescue an error' do
      it 'correctly' do
        expect { logs }.not_to raise_error
        expect(AppLogger).to have_received(:error).with(msg).exactly(1).time
      end
    end

    context 'when file path is correct and file content isn\'t correct' do
      let(:path) { './spec/fixtures/invalid_logs' }
      let(:count_expected) { 0 }

      it_behaves_like 'file processing'
    end

    context 'when file path is correct and file content is partially correct' do
      let(:path) { './spec/fixtures/mixed_logs' }
      let(:count_expected) { 89 }

      it_behaves_like 'file processing'
    end

    context 'when file path is correct and file content is correct' do
      let(:path) { './spec/fixtures/valid_logs' }
      let(:count_expected) { 100 }

      it_behaves_like 'file processing'
    end

    context 'when file path isn\'t correct' do
      let(:path) { nil }
      let(:msg) { 'file processing error' }

      before do
        allow_any_instance_of(FileError).to receive(:message).and_return(msg)
        allow(AppLogger).to receive(:error)
      end

      it_behaves_like 'rescue an error'
    end

    context 'when file reader returns incorrect log lines' do
      let(:path) { './spec/fixtures/valid_logs' }
      let(:msg) { 'logs processing error' }

      before do
        allow(Files::Reader).to receive(:call).with(path).and_return(nil)
        allow_any_instance_of(LogsError).to receive(:message).and_return(msg)
        allow(AppLogger).to receive(:error)
      end

      it_behaves_like 'rescue an error'
    end
  end
end
