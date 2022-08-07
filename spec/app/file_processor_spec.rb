# frozen_string_literal: true

describe FileProcessor do
  describe '#call' do
    subject(:logs) { described_class.call(path) }

    shared_examples 'file processing' do
      let(:msg) { "100 lines processd; #{count_expected} lines valid" }

      before do
        allow(AppLogger).to receive(:info)
      end

      it 'works correctly' do
        expect(logs.instance_of?(Array)).to be_truthy
        expect(logs.count).to eq(count_expected)
        expect(AppLogger).to have_received(:info).with(msg).exactly(1).time
      end
    end

    context 'when file path is nil' do
      let(:path) { nil }

      it 'throws an ArgumentError' do
        expect { logs }.to raise_error(ArgumentError)
      end
    end

    context 'when file path is empty string' do
      let(:path) { '' }

      it 'throws an ArgumentError' do
        expect { logs }.to raise_error(ArgumentError)
      end
    end
    context 'when invalid path' do
      shared_examples 'writes error message and return empty data set' do
        before do
          allow(AppLogger).to receive(:error)
        end

        it 'works correctly' do
          expect { logs }.not_to raise_error
          expect(logs.count).to eq(0)
          expect(AppLogger).to have_received(:error).with(msg).exactly(1).time
        end
      end

      context 'points to a dir' do
        let(:path) { './spec/fixtures' }
        let(:msg) { "Processing failure: Is a directory @ io_fillbuf - fd:10 #{path}" }

        it_behaves_like 'writes error message and return empty data set'
      end

      context 'when file does not exist' do
        let(:path) { './spec/fixtures/absent_file' }
        let(:msg) { "Processing failure: No such file or directory @ rb_sysopen - #{path}" }

        it_behaves_like 'writes error message and return empty data set'
      end
    end

    context 'when file path is correct and file content is correct' do
      let(:path) { './spec/fixtures/valid_logs' }
      let(:count_expected) { 100 }

      it_behaves_like 'file processing'
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
  end
end
