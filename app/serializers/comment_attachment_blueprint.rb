class CommentAttachmentBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :comment_id, :attachment_id

  view :extended do
    excludes :comment_id, :attachment_id
    association :attachment, blueprint: AttachmentBlueprint
  end
end
