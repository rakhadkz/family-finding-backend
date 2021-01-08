class ChildAttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :child_id, :attachment_id, :created_at, :updated_at

  view :extended do
    association :attachment, blueprint: AttachmentBlueprint
  end

end
