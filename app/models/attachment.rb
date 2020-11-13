class Attachment < ApplicationRecord
  belongs_to :child
  belongs_to :finding
end
