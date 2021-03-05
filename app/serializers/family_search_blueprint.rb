class FamilySearchBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :search_vector_id, :user_id, :child_id, :description, :created_at, :updated_at, :blocks
  association :search_vector, blueprint: SearchVectorBlueprint
  association :user, blueprint: UserBlueprint
  association :family_search_attachments, blueprint: FamilySearchAttachmentBlueprint, name: :attachments
  association :family_search_connections, blueprint: FamilySearchConnectionBlueprint, view: :connection, name: :connections
end
