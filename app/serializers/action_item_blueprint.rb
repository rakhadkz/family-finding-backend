class ActionItemBlueprint < Blueprinter::Base
  identifier :id
  fields :title, :description, :user_id, :child_id, :related_user_id, :organization_id

  view :extended do
    association :user, blueprint: UserBlueprint
    association :child, blueprint: ChildBlueprint
  end
end
