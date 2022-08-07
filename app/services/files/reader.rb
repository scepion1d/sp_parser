# frozen_string_literal: true

module Files
  class Reader
    def self.call(path)
      new(path).call
    end

    def call
      validate
      readlines
    end

    private

    attr_reader :path

    def initialize(path)
      @path = File.expand_path(path.to_s)
    end

    def validate
      return if Files::PathValidator.valid?(path) && Files::AccessValidator.valid?(path)

      raise FileError, path
    end

    def readlines
      [].tap do |lines|
        File.open(path, 'r') do |file|
          until (line = file.gets).is_a? NilClass
            lines << line
          end
        end
      end
    end
  end
end
