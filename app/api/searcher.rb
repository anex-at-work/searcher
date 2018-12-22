# frozen_string_literal: true

module Searcher
  # Searcher API
  class API < Grape::API
    format :json
    prefix :api

    resource :search do
      desc 'Search in data'
      params do
        requires :query, type: String
      end
      get do
        present Services::Searcher.new(query: params[:query]).call, with: Entities::Language
      end
    end
  end
end
