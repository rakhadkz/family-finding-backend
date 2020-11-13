class Comment < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :attachments
  belongs_to :parent, :class_name => "Comment", :foreign_key => "in_reply_to"
  has_many :replies, :class_name => "Comment", :foreign_key => "in_reply_to"
end
