module Sortable
  extend ActiveSupport::Concern

  class_methods do
    attr_reader :sortable_fields

    def sortable_by(*fields)
      @sortable_fields = fields
    end
  end

  included do
    protected

    def sort(scope)
      sort_keys = params[:sort_key]&.split(',')&.map(&:strip)
      if sort_keys.present?
        unless (sortable_fields & sort_keys).present?
          raise ActionController::BadRequest, "sort_key must be one of #{sortable_fields.join(',')}"
        end

        directions = ['asc', 'desc']
        sort_direction = (params[:sort_direction] || directions.first).downcase
        unless directions.include?(sort_direction)
          raise ActionController::BadRequest, "sort_direction must be one of #{directions.join(',')}"
        end

        order = sort_keys.reduce({}) do |order, sort_key|
          order[sort_key] = sort_direction
          order
        end

        scope = scope.reorder(order)
      else
        scope
      end
    end

    private

    def sortable_fields
      self.class.sortable_fields || []
    end
  end
end
