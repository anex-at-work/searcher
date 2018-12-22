# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Services::Searcher do
  let(:searcher) { described_class }

  context 'with common search query' do
    it 'has at least one item' do
      res = described_class.new(query: 'Lisp Common').call
      expect(res.any?).to be true
    end

    it 'has the same elements' do
      res_lisp_common = described_class.new(query: 'Lisp Common').call
      res_common_lisp = described_class.new(query: 'Common Lisp').call
      expect(res_common_lisp).to match_array(res_lisp_common)
    end

    it 'has able to search exactly' do
      res = described_class.new(query: '"Thomas Eugene"').call
      res.each do |item|
        expect(item.name).to eq 'BASIC'
      end
    end

    it 'has able to search exactly and more' do
      res_first = described_class.new(query: '"Thomas Eugene"').call
      res_second = described_class.new(query: '"Thomas Eugene Kurtz"').call
      expect(res_second).to match_array(res_first)
    end

    it 'has able to search in different fields' do
      res = described_class.new(query: 'Scripting Microsoft').call
      res.each do |item|
        expect(item.designed_by).to eq 'Microsoft'
      end
    end

    it 'has able to support negative search' do
      res = described_class.new(query: 'john -array').call
      enabled = ['BASIC', 'Haskell', 'Lisp', 'S-Lang']
      res.each do |item|
        expect(enabled).to include(item.name)
      end
    end
  end
end
