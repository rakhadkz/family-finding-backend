class ChildContactBlueprint < Blueprinter::Base
  identifier :id
  fields :child_id, :contact_id, :relationship, :parent_id, :potential_match, :is_placed, :is_confirmed, :is_disqualified, :disqualify_reason, :placed_date, :link_score_overall

  field :attachments_size, default: "0" do |connection|
    connection.attachments.size
  end

  field :comments_size, default: "0" do |connection|
    connection.comments.size
  end

  field :templates_size, default: "0" do |connection|
    connection.templates_sents.size
  end

  field :alerts_size, default: "0" do |child_contact|
    child_contact.family_searches.only_link_alerts.not_rejected.count
  end

  view :children do
    association :children, blueprint: ChildBlueprint do |connection|
      connection.contact.children
    end
  end


  view :extended do
    excludes :contact_id
    association :contact, blueprint: ContactBlueprint
  end

  view :attachments do
    association :child_contact_attachments, blueprint: ConnectionAttachmentBlueprint, view: :extended, name: :attachments
  end

  view :comments do
    association :child_contact_comments, blueprint: ConnectionCommentBlueprint, view: :extended, name: :comments
  end

  view :templates do
    association :templates_sents, blueprint: TemplatesSentBlueprint, name: :templates
  end

  view :alerts do
    association :family_searches, blueprint: FamilySearchBlueprint, name: :alerts do |child_contact|
      child_contact.family_searches.only_link_alerts.not_rejected
    end
  end

  view :link_score do
    association :link_score, blueprint: LinkScoreBlueprint
  end
end
