class AttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :file_name, :file_type, :file_url, :file_size, :user_id, :created_at, :file_format

  view :extended do
    association :user, blueprint: UserBlueprint
  end
end
