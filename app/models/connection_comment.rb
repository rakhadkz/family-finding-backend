class ConnectionComment < ApplicationRecord
  belongs_to :contact
  belongs_to :comment
end
