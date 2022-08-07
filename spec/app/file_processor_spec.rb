# frozen_string_literal: true

describe FileProcessor do
  describe '#call' do
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
      let(:err_msg) { "Processing failed: Is a directory - #{path}" }

      before do
        allow_any_instance_of(described_class).to receive(:read_file) do
          raise Errno::EISDIR, path
        end
        allow(AppLogger).to receive(:error).with(err_msg)
      end

      it 'catches an error and writes a log message' do
        expect { described_class.call(path) }.not_to raise_error
        expect(AppLogger).to have_received(:error).with(err_msg).exactly(1).time
      end
    end

    context 'when file does not exist' do
      let(:path) { '/file/is/missing' }
      let(:err_msg) { "Processing failed: No such file or directory - #{path}" }

      before do
        allow_any_instance_of(described_class).to receive(:read_file) do
          raise Errno::ENOENT, path
        end
        allow(AppLogger).to receive(:error).with(err_msg)
      end

      it 'catches an error and writes a log message' do
        expect { described_class.call(path) }.not_to raise_error
        expect(AppLogger).to have_received(:error).with(err_msg).exactly(1).time
      end
    end

    context 'when file path is correct and file content is correct' do
      let(:path) { './spec/fixtures/webserver.log' }
      let(:msg) { "#{`wc -l "#{path}"`.strip.split[0].to_i} valid lines processed" }

      before do
        allow(AppLogger).to receive(:info)
      end

      it 'process file correctly' do
        described_class.call(path)
        expect(AppLogger).to have_received(:info).with(msg).exactly(1).time
      end
    end
  end
end
