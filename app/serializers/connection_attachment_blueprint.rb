class ConnectionAttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :child_contact_id, :attachment_id
end
