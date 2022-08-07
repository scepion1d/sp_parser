# frozen_string_literal: true

# :reek:InstanceVariableAssumption
module Stat
  class TotalVisits < Stat::Base
    private

    STAT_HEADER = 'Total visits:'
    RECORD_SUFFICS = 'visits'

    def stat
      return @stat if defined?(@stat)

      data = grouped_logs.dup
      data.each do |path, visits|
        data[path] = visits.count
      end

      @stat = data
    end
  end
end
