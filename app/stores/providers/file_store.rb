# frozen_string_literal: true

require 'json'

module Stores
  module Providers
    # FileStore provider (for avoiding name confusion)
    class FileStore < Abstract
      def initialize; end

      def read(location: nil)
        raise ArgumentError, 'The location should be provided' if location.nil?

        @data = File.read location
      end

      def fetch
        JSON.parse(@data)
      end
    end
  end
end
