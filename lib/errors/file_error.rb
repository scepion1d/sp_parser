# frozen_string_literal: true

class FileError < StandardError
  def initialize(path = '')
    super("Can't process file `#{path}`")
  end
end
