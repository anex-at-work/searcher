$LOAD_PATH.unshift(File.expand_path('../app', __dir__))

require_relative 'boot'

Bundler.require :default, ENV['RACK_ENV']

Dir[File.expand_path('../app/**/*.rb', __dir__)].each do |f|
  require f
end
