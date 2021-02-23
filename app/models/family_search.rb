class FamilySearch < ApplicationRecord
  belongs_to :user
  belongs_to :search_vector
end
