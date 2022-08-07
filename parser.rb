#!/usr/bin/ruby
# frozen_string_literal: true

Dir['./lib/**/*.rb', './app/**/*.rb'].each { |file| require file }

AppLogger.use(Logger.new('logs/parser.log'))

ParserService.call(ARGV[0]).each { |stat| puts stat }
