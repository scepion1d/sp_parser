#!/usr/bin/ruby
# frozen_string_literal: true

Dir['./lib/*.rb', './app/*.rb'].each { |file| require file }

file_path = ARGV[0]

FileProcessor.call(file_path)
