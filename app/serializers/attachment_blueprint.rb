class AttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :file_name, :file_type, :file_url, :file_size, :user_id, :created_at, :file_format

  association :user, blueprint: UserBlueprint

  view :connections do
    association :child_contact_attachments, blueprint: ConnectionAttachmentBlueprint, view: :extended, name: :attachment_connections
  end
end
