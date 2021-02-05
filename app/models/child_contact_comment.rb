class ChildContactComment < ApplicationRecord
  belongs_to :child_contact
  belongs_to :comment
end
