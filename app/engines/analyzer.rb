# frozen_string_literal: true

module Engines
  # Token Analyzer class
  class Analyzer
    Token = Struct.new(:simple, :exact) do
    end

    def initialize(data: nil)
      raise ArgumentError, 'Empty data' if data.nil?

      @data = data
      @tokens = []
    end

    def tokens
      analyze
      @tokens
    end

    private

    def analyze
      @tokens = @data.values.collect { |val| to_token(val) }
    end

    def to_token(value)
      token = Token.new
      dup_value = value.dup
      dup_value.downcase!
      token.exact = dup_value.split(',').uniq
      token.simple = dup_value.delete(',').split(' ').uniq
      token
    end
  end
end
