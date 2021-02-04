class ConnectionAttachment < ApplicationRecord
  belongs_to :contact
  belongs_to :attachment
end
