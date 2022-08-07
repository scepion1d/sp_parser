# frozen_string_literal: true

describe FileProcessor do
  describe '#call' do
    shared_examples 'file processing' do
      before do
        allow(AppLogger).to receive(:info)
      end

      it 'works correctly' do
        described_class.call(path)
        expect(AppLogger).to have_received(:info).with(msg).exactly(1).time
      end
    end

    context 'when file path is nil' do
      it 'throws an ArgumentError' do
        expect { described_class.call(nil) }.to raise_error(ArgumentError)
      end
    end

    context 'when file path is empty string' do
      it 'throws an ArgumentError' do
        expect { described_class.call('') }.to raise_error(ArgumentError)
      end
    end

    context 'when file path points to a dir' do
      let(:path) { '/path/to/dir' }
      let(:msg) { "Processing failure: Is a directory - #{path}" }

      before do
        allow_any_instance_of(described_class).to receive(:read_file) do
          raise Errno::EISDIR, path
        end
        allow(AppLogger).to receive(:error).with(msg)
      end

      it 'catches an error and writes a log message' do
        expect { described_class.call(path) }.not_to raise_error
        expect(AppLogger).to have_received(:error).with(msg).exactly(1).time
      end
    end

    context 'when file does not exist' do
      let(:path) { '/file/is/missing' }
      let(:msg) { "Processing failure: No such file or directory - #{path}" }

      before do
        allow_any_instance_of(described_class).to receive(:read_file) do
          raise Errno::ENOENT, path
        end
        allow(AppLogger).to receive(:error).with(msg)
      end

      it 'catches an error and writes a log message' do
        expect { described_class.call(path) }.not_to raise_error
        expect(AppLogger).to have_received(:error).with(msg).exactly(1).time
      end
    end

    context 'when file path is correct and file content is correct' do
      let(:path) { './spec/fixtures/valid_logs' }
      let(:msg) { '100 lines processd; 100 lines valid' }

      it_behaves_like 'file processing'
    end

    context 'when file path is correct and file content isn\'t correct' do
      let(:path) { './spec/fixtures/invalid_logs' }
      let(:msg) { '100 lines processd; 0 lines valid' }

      it_behaves_like 'file processing'
    end

    context 'when file path is correct and file content is partially correct' do
      let(:path) { './spec/fixtures/mixed_logs' }
      let(:msg) { '100 lines processd; 89 lines valid' }

      it_behaves_like 'file processing'
    end
  end
end
