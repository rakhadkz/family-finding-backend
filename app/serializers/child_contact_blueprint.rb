class ChildContactBlueprint < Blueprinter::Base
  identifier :id
  fields :child_id, :contact_id, :relationship, :parent_id, :family_fit_score, :potential_match

  view :extended do
    excludes :child_id, :contact_id
    association :contact, blueprint: ContactBlueprint
  end
end
