# frozen_string_literal: true

module Stat
  class Base
    def self.get(logs, options = {})
      new(logs).get(options)
    end

    def get(options = {})
      order = options[:order]
      return sort(stat, self.class::ORDER[order]) if self.class::ORDER.key?(order)

      stat
    end

    protected

    attr_reader :logs

    ORDER = { asc: 1, dsc: -1 }.freeze

    def stat
      raise NotImplementedError
    end

    # :reek:UtilityFunction
    def sort(data, order)
      data.sort_by { |_k, val| val * order }.to_h
    end

    def grouped_logs
      @grouped_logs ||= logs.group_by { |log| log[:path] }
    end

    def initialize(logs)
      @logs = logs
    end
  end
end
