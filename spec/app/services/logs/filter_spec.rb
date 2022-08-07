# frozen_string_literal: true

module Logs
  describe Filter do
    subject(:filtered_logs) { described_class.process(raw_logs) }

    shared_examples 'filtering' do
      let(:msg) { "#{raw_logs.count} lines processd; #{expected_logs.count} lines valid" }

      before do
        allow(AppLogger).to receive(:info)
      end

      it 'works correctly' do
        expect(filtered_logs).to eq(expected_logs)
        expect(AppLogger).to have_received(:info).with(msg).exactly(1).time
      end
    end

    context 'when logs for filtering is nil' do
      let(:raw_logs) { nil }

      it 'throws an LogsError' do
        expect { filtered_logs }.to raise_error(LogsError)
      end
    end

    context 'when logs for filtering is not an array' do
      let(:raw_logs) { { test: 'test' } }

      it 'throws an LogsError' do
        expect { filtered_logs }.to raise_error(LogsError)
      end
    end

    context 'when empty array passed' do
      let(:raw_logs) { [] }
      let(:expected_logs) { [] }

      it_behaves_like 'filtering'
    end

    context 'when valid data passed' do
      let(:raw_logs) do
        [
          '/help_page/1 126.318.035.038',
          '/contact 184.123.665.067',
          '/home 184.123.665.067'
        ]
      end

      let(:expected_logs) do
        [
          { path: '/help_page/1', ip: '126.318.035.038' },
          { path: '/contact', ip: '184.123.665.067' },
          { path: '/home', ip: '184.123.665.067' }
        ]
      end

      it_behaves_like 'filtering'
    end

    context 'when invlaid data passed' do
      let(:raw_logs) do
        [
          '/helр_page/1 126.318.035.038',
          '/contact 184.123.067',
          'home 184.123.665.067',
          'invalid log line'
        ]
      end

      let(:expected_logs) { [] }

      it_behaves_like 'filtering'
    end

    context 'when partially valid data passed' do
      let(:raw_logs) do
        [
          '/help_page/1 126.318.035.038',
          '/contact 184.123.665.O67',
          '/home 184.123.665.067',
          'invalid log line'
        ]
      end

      let(:expected_logs) do
        [
          { path: '/help_page/1', ip: '126.318.035.038' },
          { path: '/home', ip: '184.123.665.067' }
        ]
      end

      it_behaves_like 'filtering'
    end
  end
end
