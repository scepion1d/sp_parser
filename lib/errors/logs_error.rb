# frozen_string_literal: true

class LogsError < StandardError
  def initialize(msg = 'Can\'t process provided logs')
    super
  end
end
