class ChildTreeContact < ApplicationRecord
  belongs_to :child
  belongs_to :contact

  belongs_to :parent, class_name: "ChildTreeContact", foreign_key: :parent_id
  has_many :children, class_name: "ChildTreeContact", foreign_key: :parent_id
end
