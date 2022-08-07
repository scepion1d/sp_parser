# frozen_string_literal: true

module Files
  class Processor
    def self.call(path)
      AppLogger.info("Processing started: `#{path}`")
      raise ArgumentError, "File path is invalid: `#{path}`" if path.to_s.empty?

      new(path).call
    ensure
      AppLogger.info("Processing finished: `#{path}`")
    end

    def call
      read_file
      filter_logs
    end

    private

    attr_reader :path, :raw_logs

    def initialize(path)
      @path = path
      @raw_logs = []
    end

    def filter_logs
      filtered_logs = Logs::Filter.process(raw_logs)
      AppLogger.info("#{raw_logs.count} lines processd; #{filtered_logs.count} lines valid")
      filtered_logs
    end

    # :reek:NilCheck
    def read_file
      File.open(path, 'r') do |file|
        until (line = file.gets).nil?
          raw_logs << line
        end
      end
    rescue Errno::ENOENT, Errno::EISDIR => error
      AppLogger.error "Processing failure: #{error.message}"
    end
  end
end
