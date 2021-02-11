class ChildContactBlueprint < Blueprinter::Base
  identifier :id
  fields :child_id, :contact_id, :relationship, :parent_id, :family_fit_score, :potential_match, :is_placed, :is_confirmed, :is_disqualified

  field :attachments_size, default: "0" do |connection|
    connection.attachments.size
  end

  field :comments_size, default: "0" do |connection|
    connection.comments.size
  end

  field :templates_size, default: "0" do |connection|

  end

  field :alerts_size, default: "0" do |connection|

  end

  view :extended do
    excludes :child_id, :contact_id
    association :contact, blueprint: ContactBlueprint
  end

  view :attachments do
    association :child_contact_attachments, blueprint: ConnectionAttachmentBlueprint, view: :extended, name: :attachments
  end

  view :comments do
    association :child_contact_comments, blueprint: ConnectionCommentBlueprint, view: :extended, name: :comments
  end
end
