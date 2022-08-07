# frozen_string_literal: true

module Stat
  class UniqueVisits < Stat::Base
    private

    def stat
      super { |visits| visits.uniq.count }
    end
  end
end
