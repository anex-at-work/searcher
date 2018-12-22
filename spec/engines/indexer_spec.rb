# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Engines::Indexer do
  let(:indexer) { described_class }
  let(:file) { File.join(ENV['ROOT_DIR'], 'data', 'data.json') }
  let(:data) { FactoryBot.build_list(:language, 5) }
  let(:json_data) do
    [{
      "Name": 'A+',
      "Type": 'Array',
      "Designed by": 'Arthur Whitney'
    },
     {
       "Name": 'ActionScript',
       "Type": 'Compiled, Curly-bracket, Procedural, Reflective, Scripting, Object-oriented class-based',
       "Designed by": 'Gary Grossman'
     }]
  end
  let(:indexer_with_data) { indexer.new(data: json_data, model: Language) }

  context 'with incorrect arguments' do
    it 'has exception with wrong data' do
      expect { indexer.new(model: Language) }.to raise_exception(ArgumentError)
    end

    it 'has exception with wrong language' do
      expect { indexer.new(data: data) }.to raise_exception(ArgumentError)
    end

    it 'has exception with wrong language (not Class)' do
      expect { indexer.new(data: data, model: 'String') }.to raise_exception(ArgumentError)
    end
  end

  context 'with correct arguments' do
    it 'has no exception with normal model' do
      expect { indexer.new(data: data, model: Language) }.not_to raise_exception
    end

    it 'has no exception with json data' do
      expect { indexer.new(data: json_data, model: Language) }.not_to raise_exception
    end

    it 'has enable search' do
      expect(indexer_with_data.search(query: 'array').any?).to be true
    end

    it 'has enable exact search' do
      expect(indexer_with_data.search(query: 'gary grossman', exactly: true).any?).to be true
    end

    it 'has return correct item' do
      ret = indexer_with_data.search(query: 'array')
      expect(ret[0].name).to eq('A+')
    end
  end
end
