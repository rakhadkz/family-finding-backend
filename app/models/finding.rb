class Finding < ApplicationRecord
  belongs_to :child
  belongs_to :search_vector
  belongs_to :user
end
