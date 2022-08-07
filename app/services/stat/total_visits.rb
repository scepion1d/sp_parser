# frozen_string_literal: true

module Stat
  class TotalVisits < Stat::Base
    private

    def stat
      super(&:count)
    end
  end
end
