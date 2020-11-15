class ChildAttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :child_id, :attachment_id

  view :extended do
    excludes :child_id, :attachment_id
    association :attachment, blueprint: AttachmentBlueprint
  end

end
