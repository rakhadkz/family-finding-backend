class SearchVectorBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :name, :description, :in_continuous_search, :organization_id
end
  