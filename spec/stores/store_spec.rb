# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Stores::Store do
  let(:store) { described_class }

  context 'when store with undefined provider' do
    it 'has exception' do
      expect { store.new(provider: :undefined) }.to raise_exception(ArgumentError)
    end
  end

  context 'when store with file provider' do
    it 'has no exception' do
      expect { store.new }.not_to raise_exception
    end
  end

  context 'when read from existing file' do
    let(:file) { File.join(ENV['ROOT_DIR'], 'data', 'data.json') }

    it 'has no exception' do
      expect { store.new.read(location: file) }.not_to raise_exception
    end

    it 'has correct data' do
      readed = store.new.read(location: file)
      expect { readed.fetch }.not_to raise_exception
    end
  end

  context 'when read from non-existing file' do
    it 'has exception' do
      file = File.join(ENV['ROOT_DIR'], 'undefined.json')
      expect { store.new.read(location: file) }.to raise_exception(Errno::ENOENT)
    end
  end
end
