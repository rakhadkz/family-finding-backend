class ChildTreeContactBlueprint < Blueprinter::Base
    identifier :id
    fields :child_id, :contact_id, :relationship, :parent_id
  
    view :extended do
      excludes :child_id, :contact_id
      association :contact, blueprint: ContactBlueprint
    end

    field :link_score_overall do |tree|
      ChildContact.find_by(child_id: tree.child_id, contact_id: tree.contact_id)&.link_score_overall
    end
  end
  