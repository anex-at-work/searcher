# frozen_string_literal: true

module Searcher
  module Entities
    # Language entity
    class Language < Grape::Entity
      expose :name, as: :Name
      expose :type, as: :Type
      expose :designed_by, as: :'Designed By'
    end
  end
end
