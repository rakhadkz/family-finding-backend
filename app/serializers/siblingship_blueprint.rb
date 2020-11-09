class SiblingshipBlueprint < Blueprinter::Base
  identifier :id

  fields :id, :child_id, :sibling_id

  view :extended do

  end

end

