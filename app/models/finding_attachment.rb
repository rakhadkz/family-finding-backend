class FindingAttachment < ApplicationRecord
  belongs_to :finding
  belongs_to :attachment
end
