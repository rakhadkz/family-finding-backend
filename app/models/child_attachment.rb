class ChildAttachment < ApplicationRecord
  belongs_to :child
  belongs_to :attachment
end
