class CommentBlueprint < Blueprinter::Base
  identifier :id
  fields :user_id, :title, :body, :in_reply_to

  view :short do
    fields :created_at, :updated_at
  end

  view :extended do
    include_view :short
    association :user, blueprint: UserBlueprint
    association :in_reply_to, blueprint:  CommentBlueprint
  end
end