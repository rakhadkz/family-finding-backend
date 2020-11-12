class CommentBlueprint < Blueprinter::Base
  identifier :id
  fields :user_id, :title, :body

  view :short do
    fields :created_at, :updated_at
  end

  view :extended do
    include_view :short
    association :parent, blueprint:  CommentBlueprint, name: :in_reply_to
    association :replies, blueprint:  CommentBlueprint
  end
end