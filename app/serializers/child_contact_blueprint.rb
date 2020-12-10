class ChildContactBlueprint < Blueprinter::Base
  identifier :id
  fields :child_id, :contact_id, :relationship, :parent_id

  view :extended do
    excludes :child_id, :contact_id
    association :contact, blueprint: ContactBlueprint
    association :children, blueprint: ContactBlueprint
    association :parent, blueprint: ContactBlueprint
  end
end
