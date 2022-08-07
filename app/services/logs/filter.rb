# frozen_string_literal: true

module Logs
  class Filter
    def self.process(raw_logs)
      unless raw_logs.instance_of?(Array)
        raise ArgumentError, "Invalid argument type: expected Array, got`#{raw_logs.class}`"
      end

      new(raw_logs).process
    end

    # :reek:NilCheck
    def process
      raw_logs.map do |log_line|
        path, ip = match(log_line.to_s)
        next if path.nil? || ip.nil?

        { path: path, ip: ip }
      end.compact
    end

    private

    LOG_FORMAT = %r{^((?:/[a-z|\d_]+)+)\s{1}((?:[0-9]{1,3}\.){3}[0-9]{1,3})$}

    attr_reader :raw_logs

    # :reek:UtilityFunction
    def match(log_line)
      match_data = log_line.match(LOG_FORMAT)
      return match_data[1], match_data[2] if match_data
    end

    def initialize(raw_logs)
      @raw_logs = raw_logs
    end
  end
end
