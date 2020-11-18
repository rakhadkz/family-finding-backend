class ActionItem < ApplicationRecord
  enum status: { open: "Open", closed: "Closed"}
end
