# frozen_string_literal: true

require 'logger'
require 'singleton'

class AppLogger
  include Singleton

  LEVELS = %i[debug info warn error fatal unknown].freeze

  class << self
    LEVELS.each do |level|
      define_method level do |msg|
        instance.logger.public_send(level, msg)
      end
    end
  end

  def logger
    @logger ||= Logger.new($stdout)
  end
end
