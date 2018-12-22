# frozen_string_literal: true

module Services
  # Searcher service
  class Searcher
    def initialize(query: nil)
      @query = query.downcase
      @ret = []
    end

    def call
      engine = Engines::Indexer.new(data: items, model: Language)
      queries.collect do |query|
        query, exactly, negative = prepare_query(query)
        intersect_result(engine.search(query: query, exactly: exactly), negative: negative)
      end
      @ret
    end

    private

    ###
    # Please paid attention.
    # With the intersection of results, here will possible to satisfy condition about "Microsoft",
    # i.e. "exactly all scripting languages designed by "Microsoft"".
    # Or, we got not only scripting languages designed by "Microsoft"
    ###
    def intersect_result(res, negative: false)
      if @ret.any?
        if negative
          @ret -= res
        else
          @ret &= res
        end
      else
        @ret = res
      end
    end

    # this is a possible bug (about ")
    def prepare_query(query)
      [query.gsub(/"|-/, ''), !query.match(/(".*")/).nil?, query.start_with?('-')]
    end

    def queries
      @query.split(/(".*")| /).reject(&:empty?)
    end

    def items
      data_file = File.join(ENV['ROOT_DIR'], 'data', 'data.json')
      Stores::Store.new.read(location: data_file).fetch
    end
  end
end
