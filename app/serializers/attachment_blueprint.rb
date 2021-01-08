class AttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :file_name, :file_type, :file_url, :file_size, :user_id, :created_at, :file_format

  association :user, blueprint: UserBlueprint
end
