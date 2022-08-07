# frozen_string_literal: true

module Logs
  class Filter
    def self.process(raw_logs)
      new(raw_logs).process
    end

    def process
      validate
      filter
    end

    private

    attr_reader :raw_logs

    def validate
      return if Logs::TypeValidator.valid?(raw_logs)

      AppLogger.error "Can't process provided logs"
      raise LogsError
    end

    def filter
      filtered_logs = raw_logs.map do |log_line|
        Logs::LineParser.process(log_line)
      rescue LogsError
        nil
      end.compact

      AppLogger.info("#{raw_logs.count} lines processd; #{filtered_logs.count} lines valid")
      filtered_logs
    end

    def initialize(raw_logs)
      @raw_logs = raw_logs
    end
  end
end
