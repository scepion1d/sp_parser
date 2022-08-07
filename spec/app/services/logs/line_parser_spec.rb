# frozen_string_literal: true

module Logs
  describe LineParser do
    subject(:log_entry) { described_class.process(log_line) }

    shared_examples 'raises a LogsError' do
      it 'works correctly' do
        expect { log_entry }.to raise_error(LogsError)
      end
    end

    context 'when log line is nil' do
      let(:log_line) { nil }

      it_behaves_like 'raises a LogsError'
    end

    context 'when log line is empty string' do
      let(:log_line) { '' }

      it_behaves_like 'raises a LogsError'
    end

    context 'when log line is invalid' do
      let(:log_line) { '/indeх 192.168.10.10' }

      it_behaves_like 'raises a LogsError'
    end

    context 'when log line is valid' do
      let(:log_line) { '/index 192.168.10.10' }
      let(:expected_entry) { { path: '/index', ip: '192.168.10.10' } }

      it 'parses log line correctly' do
        expect(log_entry).to eq(expected_entry)
      end
    end
  end
end
