module Searchable
  extend ActiveSupport::Concern

  included do
    protected

    def search(scope)
      search = params[:search]
      if search.present?
        scope.search(params[:search].gsub(/-/, '\-')).with_pg_search_rank
      else
        scope
      end
    end
  end
end
