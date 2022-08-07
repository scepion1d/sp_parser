# frozen_string_literal: true

describe LogsFilter do
  describe '#process' do
    shared_examples 'filtering' do
      before do
        allow(AppLogger).to receive(:info)
      end

      it 'works correctly' do
        expect(described_class.process(raw_logs)).to eq(filtered_logs)
      end
    end

    context 'when logs for filtering is nil' do
      it 'throws an ArgumentError' do
        expect { described_class.process(nil) }.to raise_error(ArgumentError)
      end
    end

    context 'when logs for filtering is not an array' do
      it 'throws an ArgumentError' do
        expect { described_class.process({ test: 'test' }) }.to raise_error(ArgumentError)
      end
    end

    context 'when empty array passed' do
      let(:raw_logs) { [] }

      let(:filtered_logs) { [] }

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

      let(:filtered_logs) do
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

      let(:filtered_logs) { [] }

      it_behaves_like 'filtering'
    end
  end
end
