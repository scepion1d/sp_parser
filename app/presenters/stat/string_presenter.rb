# frozen_string_literal: true

module Stat
  class StringPresenter
    def self.call(stat, options = {})
      new(options).call(stat)
    end

    def call(stat)
      report = "#{header}\n"
      stat.each do |key, val|
        report += "#{key} #{val} #{line_suffix}\n"
      end
      "#{report}\n"
    end

    private_methods :new

    private

    attr_reader :options

    DEFAULT_HEADER = 'Statistics:'
    DEFAULT_LINE_SUFFIX = ''

    def initialize(options)
      @options = options
    end

    def header
      @header ||= (options[:header] || DEFAULT_HEADER)
    end

    def line_suffix
      @line_suffix ||= (options[:line_suffix] || DEFAULT_LINE_SUFFIX)
    end
  end
end
