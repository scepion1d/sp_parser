# frozen_string_literal: true

module Stat
  class TopUniqueVisitsService < BaseService
    # :reek:FeatureEnvy
    def add_entry(log)
      stat[log[:path]] |= [log[:ip]]
    end

    def finalized_stat
      stat.transform_values(&:count).sort_by { |_key, val| -val }.to_h
    end

    def default_value
      []
    end
  end
end
