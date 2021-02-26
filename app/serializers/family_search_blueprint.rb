class FamilySearchBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :search_vector_id, :user_id, :child_id, :description, :created_at, :updated_at
  association :search_vector, blueprint: SearchVectorBlueprint
  association :user, blueprint: UserBlueprint
  association :attachments, blueprint: AttachmentBlueprint
  association :child_contacts, blueprint: ChildContactBlueprint, view: :extended
end
