# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

gem 'grape'
gem 'grape-entity'
gem 'json'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot'
  gem 'faker'
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov', require: false
end

group :development do
  gem 'rake'
  gem 'rubocop'
  gem 'rubocop-rspec'
end
