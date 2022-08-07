# frozen_string_literal: true

module Stat
  class Base
    def self.get(logs, options = {})
      new(logs).get(options)
    end

    def get(options = {})
      order = options[:order]
      return stat unless self.class::ORDER.key?(order)

      sort(order)
    end

    protected

    attr_reader :logs

    ORDER = { asc: 1, dsc: -1 }.freeze

    def stat(&block)
      raise NotImplementedError unless block_given?

      @stat ||= grouped_logs.transform_values(&block)
    end

    def sort(order)
      stat.sort_by { |_k, val| val * self.class::ORDER[order] }.to_h
    end

    def grouped_logs
      @grouped_logs ||= logs.group_by { |log| log[:path] }
    end

    def initialize(logs)
      @logs = logs
    end
  end
end
