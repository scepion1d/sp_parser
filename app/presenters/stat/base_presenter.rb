# frozen_string_literal: true

module Stat
  class BasePresenter
    def self.call(stat)
      new.call(stat)
    end

    def call(stat)
      report = "#{self.class::HEADER}\n"
      stat.each do |key, val|
        report += "#{key} #{val} #{self.class::SUFFIX}\n"
      end
      report += "\n"
    end

    private_methods :new

    HEADER = 'Statistics:'
    SUFFIX = ''
  end
end
