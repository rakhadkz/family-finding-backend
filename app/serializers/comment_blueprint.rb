class CommentBlueprint < Blueprinter::Base
  identifier :id
  fields :user_id, :title, :body, :created_at, :updated_at

  view :extended do
    association :parent, blueprint:  CommentBlueprint, name: :in_reply_to
    association :replies, blueprint:  CommentBlueprint
    association :attachment, blueprint: AttachmentBlueprint, name: :attachments
  end

  view :attachments do
    excludes :user_id, :title, :body
    association :attachments, blueprint: AttachmentBlueprint, name: :attachments
  end

end
