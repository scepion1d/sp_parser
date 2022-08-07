# frozen_string_literal: true

module Stat
  class Base
    def initialize(logs)
      @logs = logs
    end

    def print(options = {})
      puts self.class::STAT_HEADER
      get(options).each do |key, val|
        puts "#{key} #{val} #{self.class::RECORD_SUFFICS}"
      end
      puts
    end

    def get(options = {})
      order = options[:order]
      return sort(stat, 1) if order == :asc
      return sort(stat, -1) if order == :dsc

      stat
    end

    protected

    STAT_HEADER = 'TBA'
    RECORD_SUFFICS = 'TBA'

    attr_reader :logs

    def stat
      throw NotImplementedError.new
    end

    # :reek:UtilityFunction
    def sort(data, order)
      data.sort_by { |_k, val| val * order }.to_h
    end

    def grouped_logs
      @grouped_logs ||= logs.group_by { |log| log[:path] }
    end
  end
end
