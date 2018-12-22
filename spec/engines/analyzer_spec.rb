# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Engines::Analyzer do
  let(:analyzer) { described_class }
  let(:data) { FactoryBot.build(:language) }

  context 'with incorrect arguments' do
    it 'has exception with wrong data' do
      expect { analyzer.new(data: nil) }.to raise_exception(ArgumentError)
    end
  end

  context 'with correct arguments' do
    let(:tokens) { analyzer.new(data: data).tokens }

    it 'has no exception' do
      expect { analyzer.new(data: data) }.not_to raise_exception
    end

    it 'has return tokens' do
      expect(tokens.any?).to be true
    end

    it 'has contain at least type' do
      expect(tokens.collect(&:to_a).flatten).to include(data.type.split(',')[0].downcase)
    end

    it 'has contain at least name' do
      expect(tokens.collect(&:to_a).flatten).to include(data.name.downcase)
    end

    it 'has contain at least designed_by' do
      expect(tokens.collect(&:to_a).flatten).to include(data.designed_by.downcase)
    end
  end
end
