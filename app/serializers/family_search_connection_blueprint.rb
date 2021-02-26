class FamilySearchConnectionBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :family_search_id, :child_contact_id

  view :extended do
    association :family_search, blueprint: FamilySearchBlueprint
  end

end
