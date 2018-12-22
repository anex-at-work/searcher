# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Searcher::API do
  include Rack::Test::Methods

  let(:app) { described_class }

  context 'when GET with empty request' do
    subject(:resp) do
      get '/api/search'
      last_response
    end

    it 'has 400 status' do
      expect(resp.status).to eq(400)
    end
  end

  context 'when GET with request' do
    subject(:resp) do
      get '/api/search', query: Faker::Lorem.word
      last_response
    end

    it 'has 200 status' do
      expect(resp.status).to eq(200)
    end

    it 'has application/json content-type' do
      expect(resp.headers['Content-Type']).to eq('application/json')
    end
  end
end
