class ChildContact < ApplicationRecord
  belongs_to :child
  belongs_to :contact

  validates :family_fit_score, :inclusion => { :in => 0..5 }

  belongs_to :parent, class_name: "ChildContact", foreign_key: :parent_id
  has_many :children, class_name: "ChildContact", foreign_key: :parent_id
end
