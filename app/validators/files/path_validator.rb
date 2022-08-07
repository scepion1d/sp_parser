# frozen_string_literal: true

module Files
  class PathValidator < BaseValidator
    def valid?
      File.exist?(path) && File.file?(path)
    end
  end
end
