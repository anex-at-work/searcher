ENV['RACK_ENV'] ||= 'test'
ENV['ROOT_DIR'] ||= File.expand_path('../', __dir__)

require_relative 'application'
