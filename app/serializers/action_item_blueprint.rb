class ActionItemBlueprint < Blueprinter::Base
  identifier :id
  fields :title, :description, :priority_level, :status, :user_id, :child_id

  view :extended do
    association :user, blueprint: UserBlueprint
    association :child, blueprint: ChildBlueprint
  end
end
