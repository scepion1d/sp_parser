# frozen_string_literal: true

class ParsingService
  def self.call(path)
    new(path).call
  end

  def call
    AppLogger.info("Processing started: `#{path}`")
    process
  rescue FileError, LogsError => error
    AppLogger.error error.message
  ensure
    AppLogger.info("Processing finished: `#{path}`")
  end

  private

  attr_reader :path

  def initialize(path)
    @path = path
  end

  def process
    raw_logs = Files::Reader.call(path)
    Logs::Filter.process(raw_logs)
  end
end
