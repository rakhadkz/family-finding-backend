class ChildBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :first_name,
         :last_name,
         :birthday

  view :siblings do
    association :siblings, blueprint: SiblingshipBlueprint
  end

end
