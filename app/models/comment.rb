class Comment < ApplicationRecord
  belongs_to :user

  belongs_to :parent, :class_name => "Comment", :foreign_key => "in_reply_to"
  has_many :children, :class_name => "Comment", :foreign_key => "in_reply_to"
end
