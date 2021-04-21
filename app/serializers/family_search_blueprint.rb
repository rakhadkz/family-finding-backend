class FamilySearchBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :search_vector_id, :child_contact_id, :user_id, :child_id, :description, :created_at, :updated_at, :blocks, :date_completed, :date_rejected, :date_accepted, :is_link_alert
  association :search_vector, blueprint: SearchVectorBlueprint
  association :user, blueprint: UserBlueprint
  association :child_contact, blueprint: ChildContactBlueprint, view: :extended, name: :connection
  association :family_search_attachments, blueprint: FamilySearchAttachmentBlueprint, name: :attachments
  association :family_search_connections, blueprint: FamilySearchConnectionBlueprint, view: :connection, name: :connections
end
