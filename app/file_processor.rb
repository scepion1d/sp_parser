# frozen_string_literal: true

class FileProcessor
  def self.call(path)
    safe_path = path.to_s
    raise ArgumentError, "File path is invalid: `#{safe_path}`" if safe_path.empty?

    AppLogger.info("Processing started: `#{safe_path}`")
    new(safe_path).call
    AppLogger.info("Processing finished: `#{safe_path}`")
  end

  def call
    read_file
    parsed_logs = raw_logs

    AppLogger.info("#{parsed_logs.count} valid lines processed")
  rescue Errno::ENOENT, Errno::EISDIR => error
    AppLogger.error "Processing failed: #{error.message}"
  end

  private

  attr_reader :path, :raw_logs, :parsed_logs

  def initialize(path)
    @path = path
    @raw_logs = []
    @parsed_logs = []
  end

  # :reek:NilCheck
  def read_file
    File.open(path, 'r') do |file|
      until (line = file.gets).nil?
        raw_logs << line
      end
    end
  end
end
