class CommentBlueprint < Blueprinter::Base
  identifier :id
  fields :user_id, :title, :body, :created_at, :updated_at, :child_id

  view :extended do
    association :parent, blueprint:  CommentBlueprint, name: :in_reply_to
    association :replies, blueprint:  CommentBlueprint, view: :extended
    association :attachments, blueprint: AttachmentBlueprint, name: :attachments
    association :user, blueprint:  UserBlueprint
  end

  view :attachments do
    excludes :user_id, :title, :body
    association :attachments, blueprint: AttachmentBlueprint, name: :attachments
  end

end
