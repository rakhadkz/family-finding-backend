class ChildContactAttachment < ApplicationRecord
  belongs_to :child_contact
  belongs_to :attachment
end
