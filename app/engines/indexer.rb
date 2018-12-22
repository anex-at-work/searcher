# frozen_string_literal: true

require 'digest'

module Engines
  # Inverted index implementation
  class Indexer
    def initialize(data: nil, model: nil)
      raise ArgumentError, 'Empty data' if data.nil?
      raise ArgumentError, 'Model should be a Class' if model.nil? || !model.is_a?(Class)

      @data = data
      @model = model
      @simpleindex = {}
      @exactindex = {}
      @indexed = {}
      analyze
    end

    def search(query: nil, exactly: false)
      return from_index_data(in_exactly_index(query)) if exactly

      from_index_data(@simpleindex[query])
    end

    private

    def analyze
      @data.each do |data|
        data = to_document(data) unless data.is_a? @model
        tokens = Analyzer.new(data: data).tokens
        hash = to_index_data(data)
        combine(hash, tokens)
      end
    end

    def in_exactly_index(query)
      ret = @exactindex[query] || []
      ret + @exactindex.collect { |k, v| return v if k.include?(query) }
    end

    def from_index_data(hashes)
      return [] if hashes.nil?

      hashes.collect { |hash| @indexed[hash] }
    end

    def to_index_data(data)
      hash = Digest::SHA2.new(256).hexdigest(data.values.to_s)
      @indexed[hash] = data
      hash
    end

    def combine(hash, tokens)
      tokens.each do |token|
        push_to_index hash, token.simple, @simpleindex
        push_to_index hash, token.exact, @exactindex
      end
    end

    def push_to_index(hash, tokens_in_doc, index)
      tokens_in_doc.each do |token|
        if index.key?(token)
          index[token].push(hash)
        else
          index[token] = [hash]
        end
      end
    end

    def to_document(data)
      data.keys.each do |key|
        data[key_as_param(key)] = data.delete(key)
      end
      @model.new(*data.values_at(*@model.members))
    end

    def key_as_param(key)
      key.to_s.tr(' ', '_').downcase.to_sym
    end
  end
end
