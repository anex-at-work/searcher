# frozen_string_literal: true

module Stores
  module Providers
    # Abstract class
    # :nocov:
    class Abstract
      def initialize
        raise 'Abstract method'
      end

      def read
        raise 'Abstract method'
      end

      def fetch
        raise 'Abstract method'
      end
    end
    # :nocov:
  end
end
