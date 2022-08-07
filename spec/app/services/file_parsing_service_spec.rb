# frozen_string_literal: true

describe FileParsingService do
  describe '#call' do
    subject(:service_call) { described_class.call(path, parser, aggregators) }

    let(:parser) { LogParserService }
    let(:aggregator) { Stat::TopTotalVisitsService.new }
    let(:aggregators) { [->(log) { aggregator.add_entry(log) }] }

    shared_examples 'file processing' do
      let(:log_entry) { 'log entry' }

      it 'parses expected number of lines' do
        allow(parser).to receive(:call)

        expect { service_call }.not_to raise_error
        expect(parser).to have_received(:call).exactly(lines_count).time
      end

      it 'process only valid lines' do
        allow(aggregator).to receive(:add_entry)

        expect { service_call }.not_to raise_error
        expect(aggregator).to have_received(:add_entry).exactly(valid_lines_count).time
      end
    end

    context 'when file path isn\'t correct' do
      let(:path) { nil }
      let(:error_msg) { 'file processing error' }
      let(:log_msg) { "Processing failure: #{error_msg}" }

      before do
        allow_any_instance_of(FileError).to receive(:message).and_return(error_msg)
        allow(AppLogger).to receive(:error)
      end

      it 'rescue a FileError' do
        expect { service_call }.not_to raise_error
        expect(AppLogger).to have_received(:error).with(log_msg).exactly(1).time
      end
    end

    context 'when file path is correct and file content isn\'t correct' do
      let(:path) { './spec/fixtures/invalid_logs' }
      let(:lines_count) { 100 }
      let(:valid_lines_count) { 0 }

      it_behaves_like 'file processing'
    end

    context 'when file path is correct and file content is partially correct' do
      let(:path) { './spec/fixtures/mixed_logs' }
      let(:lines_count) { 100 }
      let(:valid_lines_count) { 89 }

      it_behaves_like 'file processing'
    end

    context 'when file path is correct and file content is correct' do
      let(:path) { './spec/fixtures/valid_logs' }
      let(:lines_count) { 100 }
      let(:valid_lines_count) { 100 }

      it_behaves_like 'file processing'
    end
  end
end
