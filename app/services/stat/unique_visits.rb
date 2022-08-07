# frozen_string_literal: true

# :reek:InstanceVariableAssumption
module Stat
  class UniqueVisits < Stat::Base
    private

    def stat
      return @stat if defined?(@stat)

      data = grouped_logs.dup
      data.each do |path, visits|
        data[path] = visits.uniq.count
      end

      @stat = data
    end
  end
end
