class CommentAttachment < ApplicationRecord
  belongs_to :comment
  belongs_to :attachment
end
