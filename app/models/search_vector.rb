class SearchVector < ApplicationRecord
  has_many :findings
  has_many :children, through: :findings
end
