class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :child

  has_many :comment_attachments
  has_many :attachments, through: :comment_attachments

  belongs_to :parent, class_name: "Comment", foreign_key: "in_reply_to"
  has_many :replies, class_name: "Comment", foreign_key: "in_reply_to"

  has_many :connection_comments
  has_many :contacts, through: :connection_comments
end
