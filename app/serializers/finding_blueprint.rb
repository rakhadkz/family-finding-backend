class FindingBlueprint < Blueprinter::Base
  identifier :id

  fields :id,
         :child_id,
         :search_vector_id,
         :user_id,
         :description

  view :extended do
    association :user, blueprint: UserBlueprint, view: :extended
    association :child, blueprint: ChildBlueprint
    association :search_vector, blueprint: SearchVectorBlueprint
  end
end
