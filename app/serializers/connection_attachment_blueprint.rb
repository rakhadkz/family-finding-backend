class ConnectionAttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :child_contact_id, :attachment_id, :created_at, :updated_at

  view :extended do
    association :attachment, blueprint: AttachmentBlueprint
    association :child_contact, blueprint: ChildContactBlueprint, view: :extended, name: :connection
  end
end
