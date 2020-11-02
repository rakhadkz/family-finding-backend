module Filterable
  extend ActiveSupport::Concern

  RELATIONS = ['=', '!=', '>', '>=', '<', '<=']

  class_methods do
    attr_reader :filterable_fields

    def filterable_by(*fields)
      @filterable_fields = fields
    end
  end

  included do
    protected

    def filter(scope)
      filterable_fields.reduce(scope) do |scope, field|
        value = params[field]
        if value.present?
          rel = params["#{field}.rel"] || '='
          raise ArgumentError, "rel must be one of: #{RELATIONS.join(', ')}" unless RELATIONS.include?(rel)
          scope = scope.where("#{field} #{rel} ?", value)
        else
          scope
        end
      end
    end

    private

    def filterable_fields
      self.class.filterable_fields || []
    end
  end
end
