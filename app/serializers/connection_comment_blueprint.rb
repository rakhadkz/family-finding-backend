class ConnectionCommentBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :child_contact_id, :comment_id, :created_at, :updated_at

  view :extended do
    association :comment, blueprint: CommentBlueprint, view: :user
  end
end
