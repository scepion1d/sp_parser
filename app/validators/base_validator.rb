# frozen_string_literal: true

class BaseValidator
  def self.valid?(*args)
    new(args).valid?
  end

  def valid?
    raise NotImplementedError
  end

  protected

  attr_reader :args

  def initialize(args)
    @args = args
  end
end
