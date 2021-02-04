class Attachment < ApplicationRecord
  has_many :finding_attachments
  has_many :findings, through: :finding_attachments

  has_many :comment_attachments
  has_many :comments, through: :comment_attachments

  has_many :child_attachments
  has_many :children, through: :child_attachments

  belongs_to :user

  has_many :connection_attachments
  has_many :contacts, through: :connection_attachments
end
