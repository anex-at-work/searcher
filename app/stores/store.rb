# frozen_string_literal: true

module Stores
  # Store
  class Store
    # right now, we have only one
    def initialize(provider: :file_store)
      case provider
      when :file_store
        @provider = Providers::FileStore.new
      else
        raise ArgumentError, 'Undefined provider'
      end
    end

    def fetch
      @provider.fetch
    end

    def read(*args)
      @provider.read(*args)
      self
    end
  end
end
