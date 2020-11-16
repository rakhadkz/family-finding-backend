class ChildContact < ApplicationRecord
  belongs_to :child
  belongs_to :contact
end
