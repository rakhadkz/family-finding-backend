class ActionItem < ApplicationRecord
  belongs_to :user
  belongs_to :child
  enum status: { Open: "Open", Closed: "Closed"}
end
