class SiblingshipBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :child_id, :sibling_id, :sibling_type

  view :extended do
    excludes :child_id, :sibling_id
    association :child, blueprint: ChildBlueprint
    association :sibling, blueprint: ChildBlueprint
  end
end

