# frozen_string_literal: true

require './app/validators/files/base_validator'

module Files
  class AccessValidator < BaseValidator
    def valid?
      File.readable?(path)
    end
  end
end
