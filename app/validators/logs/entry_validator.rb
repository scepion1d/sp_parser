# frozen_string_literal: true

module Logs
  class EntryValidator < BaseValidator
    def valid?
      !!args[0].to_s.match(LOG_FORMAT)
    end

    LOG_FORMAT = %r{^((?:/[a-z|\d_]+)+)\s{1}((?:[0-9]{1,3}\.){3}[0-9]{1,3})$}
  end
end
