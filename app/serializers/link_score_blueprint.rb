class LinkScoreBlueprint < Blueprinter::Base
  identifier :id
  fields :id, :criminal_history, :demographics, :financial, :housing, :transportation
end
