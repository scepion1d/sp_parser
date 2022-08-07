# frozen_string_literal: true

module Stat
  class TopTotalVisitsService < BaseService
    def add_entry(log)
      stat[log[:path]] += 1
    end

    def finalized_stat
      stat.sort_by { |_key, val| -val }.to_h
    end

    DEFAULT_VALUE = 0
  end
end
