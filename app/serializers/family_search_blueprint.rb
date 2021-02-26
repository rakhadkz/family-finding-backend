class FamilySearchBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :search_vector_id, :description, :user_id, :created_at, :updated_at
end
