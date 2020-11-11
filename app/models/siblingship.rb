class Siblingship < ApplicationRecord
  belongs_to :child
  belongs_to :sibling, :class_name => 'Child'
end
