class ActionItem < ApplicationRecord
  belongs_to :user
  belongs_to :child
  belongs_to :related_user, class_name: "User", foreign_key: "related_user_id"

  scope :active, -> { where(date_removed: nil) }

  enum action_type: {
    "mention": "mention",
    "access_request": "access_request",
    "access_granted": "access_granted",
    "access_denied": "access_denied"
  }
end
