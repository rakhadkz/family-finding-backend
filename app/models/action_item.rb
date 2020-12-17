class ActionItem < ApplicationRecord
  belongs_to :user
  belongs_to :child
  scope :active, -> { where(date_removed: nil) }
end
