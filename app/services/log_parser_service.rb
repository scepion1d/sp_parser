# frozen_string_literal: true

class LogParserService
  def self.call(log_line)
    new(log_line).call
  end

  def call
    validate
    map
  end

  private

  LOG_MAP = { path: 0, ip: 1 }.freeze

  attr_reader :log_line

  def map
    preparsed = log_line.split
    LOG_MAP.transform_values { |index| preparsed[index] }
  end

  def validate
    return if Logs::EntryValidator.valid?(log_line)

    raise LogsError, "Invalid log line #{log_line.inspect}"
  end

  def initialize(log_line)
    @log_line = log_line
  end
end
